import 'dart:convert';
import 'dart:io';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'loginStatus.dart';
import 'impact.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'steps.dart';


// day must be a string 'YYYY-MM-DD'
Future<List<Steps>?> requestData(day) async {
  //Initialize the result
  List<Steps>? result;

  final sp = await SharedPreferences.getInstance();
  var access = sp.getString('access');
  var refresh = sp.getString('refresh');
  if (access == null || refresh == null) {
    return null;
  }

  //If access and/or refresh token is expired, refresh it/them
  if (JwtDecoder.isExpired(access)) {
    if (JwtDecoder.isExpired(refresh)) {
      getTokenPair();
    } else {
      await refreshTokens();
    }
    access = sp.getString('access'); // get the access token
  }

  //Create the (representative) request
  final url =
      Impact.baseURL +
      Impact.stepsEndpoint +
      Impact.patientUsername +
      '/day/$day/';
  final headers = {HttpHeaders.authorizationHeader: 'Bearer $access'};

  //Get the response
  //print('Calling: $url');
  final response = await http.get(Uri.parse(url), headers: headers);

  //if OK parse the response, otherwise return null
  if (response.statusCode == 200) {
    final decodedResponse = jsonDecode(response.body);
    result = [];
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
  } //else

  return result;
}
