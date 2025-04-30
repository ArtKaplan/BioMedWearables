import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_app/screens/homePage.dart';
import 'package:the_app/screens/loginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<bool> _isLoggedOn() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getBool('login_status') ?? false; // '??' means if null so it returns the sp excepts if it's null where it returns false
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<bool>(
        future: _isLoggedOn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading spinner while waiting
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            // if there is an error
            return const Scaffold(
              body: Center(child: Text('Error loading app')),
            );
          } else {
            // go to homePage if logged in otherwise to loginPage
            return snapshot.data! ? HomePage() : LoginPage();
          }
        },
      ),
    );
  }
}
