import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_app/screens/homePage.dart';
import 'package:the_app/utils/impact.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: userController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                  hintText: 'Enter username',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15.0,
                top: 15,
                bottom: 15,
              ),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter password',
                ),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ElevatedButton(
                onPressed: () {
                  _tryLogin(
                    context,
                    userController.text,
                    passwordController.text,
                  );
                },
                child: Text('Login'),
              ),
            ),
            SizedBox(height: 130),
            ElevatedButton(
              child: Text('login (debug)'),
              onPressed: () {
                _loginSuccessful(context);
              },
            ),
          ],
        ),
      ),
    );
  } //build
} //ProfilePage

// check if the server is up, then if credentials are correct and act accordingly (logged and move to home or text of wrong credentials)
_tryLogin(BuildContext context, username, password) async {
  if (await _isServerOnline()) {
    if (await _isCredentialsCorrect(username = username, password = password)) {
      _loginSuccessful(context);
    } else {
      _loginWrong(context);
    }
  } else {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Cannot reach server')));
  }
}

// ask the server is the creditenials in parameters are correct
Future<bool> _isCredentialsCorrect(String username, String password) async {
  final url = Impact.baseURL + Impact.tokenEndpoint;
  final uri = Uri.parse(url);
  final body = {'username': username, 'password': password};
  final response = await http.post(uri, body: body);
  return response.statusCode == 200;
}

//check if the server is online
Future<bool> _isServerOnline() async {
  final url = Impact.baseURL + Impact.pingEndpoint;
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  return response.statusCode == 200;
}

// write a message saying the credentials are wrong
_loginWrong(BuildContext context) {
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(const SnackBar(content: Text('Wrong credentials')));
}

// go to homepage and set the login status to logged in
_loginSuccessful(BuildContext context) async {
  //await otherwise go to homepage without the status changed yet and come back
  await _setLoggedIn(); // set the loggin status and the date

  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (_) => const HomePage()),
    (route) => false, // removes all previous routes
  );
}

// set the loginstatus as logged in in shared preferences
_setLoggedIn() async {
  final sp = await SharedPreferences.getInstance();
  await sp.setBool('login_status', true);
  await sp.setString('last_login', DateTime.now().toIso8601String());
}
