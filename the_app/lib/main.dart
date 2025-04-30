import 'package:flutter/material.dart';
import 'package:the_app/screens/homePage.dart';
import 'package:the_app/screens/loginPage.dart';
import 'package:the_app/screens/sessionExpiredPage.dart';
import 'package:the_app/utils/loginStatus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<LoginStatus>(
        future: checkLoginStatus(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          switch (snapshot.data) {
            case LoginStatus.loggedIn:
              return  HomePage();
            case LoginStatus.expired:
              return SessionExpiredPage();
            default:
              return  LoginPage();
          }
        },
      ),
    );
  }
}
