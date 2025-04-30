import 'package:flutter/material.dart';
import 'package:the_app/widgets/logoutButton.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Setting Page')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: Text('To the home'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            LogoutButton(),
          ],
        ),
      ),
    );
  } //build
} //SettingPage
