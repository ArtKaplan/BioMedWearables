import 'package:shared_preferences/shared_preferences.dart';

enum LoginStatus { loggedIn, loggedOut, expired }

Future<LoginStatus> checkLoginStatus() async {
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
