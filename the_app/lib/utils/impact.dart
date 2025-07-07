import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:the_app/utils/heartRatesDay.dart';
import 'loginStatus.dart';
import 'steps.dart';

class Impact {
  static const baseURL = 'https://impact.dei.unipd.it/bwthw/';
  static const pingEndpoint = '/gate/v1/ping/';
  static const tokenEndpoint = '/gate/v1/token/';
  static const refreshEndpoint = '/gate/v1/refresh/';
  static const stepsEndpoint = 'data/v1/steps/patients/';
  static const heartRatesEndpoint = 'data/v1/heart_rate/patients/';
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

  // day must be a string 'YYYY-MM-DD'
  static Future<List<Steps>?> stepsDuringDay(day) async {
    //Initialize the result
    List<Steps>? result;

    var access = await _getAccess(); // get the access token

    //Create the (representative) request
    final url = '${Impact.baseURL}${Impact.stepsEndpoint}${Impact.patientUsername}/day/$day/';
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};

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
      result = null;
    }

    return result;
  } //StepsDuringDay

  // day must be a string 'YYYY-MM-DD'
  static Future<List<HeartRatesDay>?> heartRateDuringDay(day) async {
    //Initialize the result
    List<HeartRatesDay>? result;

    var access = await _getAccess(); // get the access token

    //Create the (representative) request
    final url = '${Impact.baseURL}${Impact.heartRatesEndpoint}${Impact.patientUsername}/day/$day/';
    final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};

    //Get the response
    final response = await http.get(Uri.parse(url), headers: headers);

    //if OK parse the response, otherwise return null
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      result = [];

      if (decodedResponse["data"].isEmpty) return [];

      for (var i = 0; i < decodedResponse['data']['data'].length; i++) {
        result.add(
          HeartRatesDay.fromJson(
            decodedResponse['data']['date'],
            decodedResponse['data']['data'][i],
          ),
        );
      } //for
    } //if
    else {
      result = null;
    }

    return result;
  } //heartRateDuringDay
  

}

// updates the tokens if expired
Future<String?>? _getAccess() async {
  final sp = await SharedPreferences.getInstance();
  var access = sp.getString('access');
  var refresh = sp.getString('refresh');
  if (access == null || refresh == null) {
    // shouldn't happen (if not logged in)
    return null;
  }

  if (JwtDecoder.isExpired(access)) {
    if (JwtDecoder.isExpired(refresh)) {
      await getTokenPair();

    } else {
      await refreshTokens();
    }
    access = sp.getString('access'); // get the access token
  } // if

  return access;
} // _getAccess
