import 'package:flutter/material.dart';
import 'package:the_app/screens/loginPage.dart';
import 'package:the_app/utils/loginStatus.dart';

// button to change loggin status and go back to login page

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  //change logout status and go to login page
  Future<void> _logout(BuildContext context) async {
    logOutInfo();

    Navigator.pushAndRemoveUntil(
      // supress all screens so cannot come back from login page
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false, // remove all previous routes
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.logout),
      label: const Text('Logout'),
      onPressed: () => _logout(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
    );
  }
}
