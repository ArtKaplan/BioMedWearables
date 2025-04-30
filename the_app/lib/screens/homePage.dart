import 'package:flutter/material.dart';
import 'package:the_app/screens/profilePage.dart';
import 'package:the_app/screens/settingsPage.dart';
import 'package:the_app/screens/hikesPage.dart';
import 'package:the_app/utils/loginStatus.dart';
import 'package:the_app/screens/sessionExpiredPage.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<LoginStatus> _checkStatus() => checkLoginStatus();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LoginStatus>(
      future: _checkStatus(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.data == LoginStatus.expired) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const SessionExpiredPage()),
              (route) => false,
            );
          });
          return const SizedBox();// empty placeholder
        }

        return _buildHomeScreen(context);// the normal homescreen, when logged in
      },
    );
  }

  Widget _buildHomeScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ElevatedButton(
              child: const Text('To the profile'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfilePage()),
                );
              },
            ),

            ElevatedButton(
              child: const Text('To the hikes'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HikesPage()),
                );
              },
            ),

            ElevatedButton(
              child: const Text('To the settings'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

