import 'package:flutter/material.dart';
import 'package:the_app/screens/homePage.dart';
import 'package:the_app/widgets/logoutButton.dart';
import 'package:the_app/widgets/testExpiracyDateButton.dart';
import 'package:the_app/widgets/LoginStatusButton.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Test Page')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: Text('To the home'),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => HomePage()),
                  (route) => false,
                );
              },
            ),

            LogoutButton(),

            TestExpiracyDateButton(),

            LoginStatusButton(),
          ],
        ),
      ),
    );
  } //build
} //testPage
