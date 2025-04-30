import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_app/screens/homePage.dart';

class LoginPage extends StatelessWidget {

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Page')),
      body: Center(
        child: ElevatedButton(
          child: Text('login'),
          onPressed: () {
            _login_successful(context);
          },
        ),
      ),
    );
  } //build
} //ProfilePage

_login_successful(BuildContext context) async {

  //await otherwise go to homepage without the status changed yet and come back
  await _set_logged_in(); // set the loggin status and the date

  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (_) => const HomePage()),
    (route) => false, // removes all previous routes
  );


}

_set_logged_in() async {
  final sp = await SharedPreferences.getInstance();
  await sp.setBool('login_status', true);
  await sp.setString('last_login', DateTime.now().toIso8601String());
}
