import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_app/screens/homePage.dart';

class LoginPage extends StatelessWidget {
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

_login_successful(BuildContext context) {
  _set_logged_in();

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => HomePage()),
  );

}

_set_logged_in() async {
  final sp = await SharedPreferences.getInstance();
  await sp.setBool('login_status', true);
}
