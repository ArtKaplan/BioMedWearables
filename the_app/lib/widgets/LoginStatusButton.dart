import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginStatusButton extends StatelessWidget {
  const LoginStatusButton({super.key});

  Future<void> _checkStatus(BuildContext context) async {
    final sp = await SharedPreferences.getInstance();
    final bool isLoggedIn = sp.getBool('login_status') ?? false;
    final String? lastLoginString = sp.getString('last_login');

    String message;

    if (!isLoggedIn || lastLoginString == null) {
      message = 'User is logged out.';
    } else {
      final DateTime lastLogin =
          DateTime.tryParse(lastLoginString) ?? DateTime(2000);
      final int daysAgo = DateTime.now().difference(lastLogin).inDays;

      if (daysAgo > 30) {
        message = 'Session expired: Last login was $daysAgo days ago.';
      } else {
        message = 'User is logged in.\nLast login: $daysAgo days ago.';
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 3)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _checkStatus(context),
      icon: const Icon(Icons.verified_user),
      label: const Text('Check Login Status'),
    );
  }
}
