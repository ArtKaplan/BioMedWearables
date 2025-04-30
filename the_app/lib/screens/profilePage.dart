import 'package:flutter/material.dart';
import 'package:the_app/widgets/logoutButton.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profil Page')),
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
} //ProfilePage
