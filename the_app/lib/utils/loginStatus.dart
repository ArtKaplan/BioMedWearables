import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_app/provider/settings_provider.dart';
import 'package:the_app/provider/stepsProvider.dart';
import 'impact.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum LoginStatus { loggedIn, loggedOut, expired }

Future<LoginStatus> checkLoginStatus({SettingsProvider? settingsProvider}) async {
  final sp = await SharedPreferences.getInstance();
  final bool isLoggedIn = sp.getBool('login_status') ?? false;
  final String? lastLoginString = sp.getString('last_login');

  if (!isLoggedIn || lastLoginString == null) return LoginStatus.loggedOut;

  final DateTime lastLogin = DateTime.parse(lastLoginString);
  final int daysSince = DateTime.now().difference(lastLogin).inDays;

  if (daysSince > 30) {
    await sp.setBool('login_status', false); // Invalidate session
    return LoginStatus.expired;
  }
  return LoginStatus.loggedIn;
}

Future<void> logOutInfo({StepsProvider? stepsProvider}) async {
  final sp = await SharedPreferences.getInstance();
  /*
  if(stepsProvider != null){
    print('logOutInfo: stepsProvider != null');
    await stepsProvider.cleanPresentationData();
  }*/
  
  //await sp.remove('stepsEachDay_${sp.getString('username')}');
  await sp.setBool('login_status', false);
  await sp.remove('username');
  await sp.remove('password');
  await sp.remove('access');
  await sp.remove('refresh');

  //##########################################################################################
  //##########################################################################################
  //only for debug purposes!!! DO NOT LEAVE IT UNCOMMENTED AFTER NOT NEEDING IT ANYMORE TODO
  //await sp.clear(); DELETES ENTIRE SHARED PREFS
  //##########################################################################################
  //##########################################################################################

}

Future<void> getTokenPair() async {
  final sp = await SharedPreferences.getInstance();

  String? username = sp.getString('username');
  String? password = sp.getString('password');

  if (username == null || password == null) {
    return;
  } else {
    final url = Impact.baseURL + Impact.tokenEndpoint;
    final body = {"username": username, "password": password};

    final response = await http.post(Uri.parse(url), body: body);

    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      sp.setString('access', decodedResponse['access']);
      sp.setString('refresh', decodedResponse['refresh']);
      print('Tokens saved');
    }
  }
}

Future<void> refreshTokens() async {
  final url = Impact.baseURL + Impact.refreshEndpoint;
  final sp = await SharedPreferences.getInstance();
  final refresh = sp.getString('refresh');
  final body = {'refresh': refresh};

  final response = await http.post(Uri.parse(url), body: body);

  if (response.statusCode == 200) {
    final decodedResponse = jsonDecode(response.body);
    final sp = await SharedPreferences.getInstance();
    sp.setString('access', decodedResponse['access']);
    sp.setString('refresh', decodedResponse['refresh']);
    print('token refreshed succesfully');
  } else {
    print(
        'refreshTokens() : Failed to refresh token patients: ${response.statusCode}',
      );
  }
}
