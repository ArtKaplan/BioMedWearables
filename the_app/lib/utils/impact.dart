import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'loginStatus.dart';
import 'steps.dart';

class Impact {
  static const baseURL = 'https://impact.dei.unipd.it/bwthw/';
  static const pingEndpoint = '/gate/v1/ping/';
  static const tokenEndpoint = '/gate/v1/token/';
  static const refreshEndpoint = '/gate/v1/refresh/';
  static const stepsEndpoint = 'data/v1/steps/patients/';
  static const patientUsername = 'Jpefaq6m58';

  // day must be a string 'YYYY-MM-DD'
  static Future<int?> totalStepsDuringDay(String day) async {
    final stepsList = await stepsDuringDay(day);

    if (stepsList == null || stepsList.isEmpty) {
      return 0;
    }

    int total = 0;
    for (var step in stepsList) {
      total += step.value;
    }

    return total;
  }


/*
   //to debug when impact (my code) doesn't work
  static Future<List<Steps>> stepsDuringDay(String date) async {
    await Future.delayed(Duration(milliseconds: 100)); // Simulate delay

    // Parse date in format 'YYYY-MM-DD'
    final parts = date.split('-');
    if (parts.length != 3) {
      throw FormatException('Date must be in YYYY-MM-DD format');
    }

    final year = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final day = int.parse(parts[2]);

    return [
      Steps(
        time: DateTime.parse(date).add(Duration(hours: 9)),
        value: year,
      ),
      Steps(
        time: DateTime.parse(date).add(Duration(hours: 12)),
        value: year + day,
      ),
      Steps(
        time: DateTime.parse(date).add(Duration(hours: 16)),
        value: year + month,
      ),
      Steps(
        time: DateTime.parse(date).add(Duration(hours: 20)),
        value: year + month+ day,
      ),
    ];
  } 
*/


  // day must be a string 'YYYY-MM-DD'
  static Future<List<Steps>?> stepsDuringDay(day) async {
    //Initialize the result
    List<Steps>? result;

    var access = await _getAccess(); // get the access token

    //Create the (representative) request
    final url = Impact.baseURL + Impact.stepsEndpoint + Impact.patientUsername + '/day/$day/';
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};

    print(url); //TODO

    //Get the response
    final response = await http.get(Uri.parse(url), headers: headers);

    //if OK parse the response, otherwise return null
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      result = [];

      if (decodedResponse["data"].isEmpty) return [];

      for (var i = 0; i < decodedResponse['data']['data'].length; i++) {
        result.add(
          Steps.fromJson(
            decodedResponse['data']['date'],
            decodedResponse['data']['data'][i],
          ),
        );
      } //for
    } //if
    else {
      print('Failed to fetch steps: ${response.statusCode} - ${response.body}');
      result = null;
    }

    return result;
  } //StepsDuringDay
  

  static Future<void> printPatientsList() async {
    var access = await _getAccess();
    if (access == null) {
      print('Access token not available');
      return;
    }
    
    final url = '$baseURL/study/v1/patients/';
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};
    print('Using access token: $access');
    print('Headers: $headers');


    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final patients = decoded['data'];

      print('Patients List:');
      for (var patient in patients) {
        print(patient);
      }
    } else {
      print(
        'Failed to fetch patients: ${response.statusCode} - ${response.body}',
      );
    }
  } //printPatientList
}

// updates the tokens if expired
_getAccess() async {
  final sp = await SharedPreferences.getInstance();
  var access = sp.getString('access');
  var refresh = sp.getString('refresh');
  if (access == null || refresh == null) {
    // shouldn't happen (if not logged in)
    print('_getAccess : both tokens are null');
    return null;
  }

  if (JwtDecoder.isExpired(access)) {
    print('_getAccesss : access is expired');
    if (JwtDecoder.isExpired(refresh)) {
      print('_getAccesss : refresh is expired');
      await getTokenPair();
      access = sp.getString('access'); //debug TODO
      refresh = sp.getString('refresh'); //debug TODO
      print('New access: $access');
      print('New refresh: $refresh');
    } else {
      await refreshTokens();
    }
    access = sp.getString('access'); // get the access token
  } // if

  return access;
} // _getAccess
