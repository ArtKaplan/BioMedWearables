import 'package:flutter/material.dart';
import 'package:the_app/screens/homePage.dart';
import 'package:the_app/screens/achievementsPage.dart';
import 'package:the_app/screens/hikesPage.dart';
import 'package:the_app/screens/profilePage.dart';
import 'package:the_app/screens/settingsPage.dart';


class Recommendhikepage extends StatelessWidget {
  const Recommendhikepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('recommended hike'),
      ),
      bottomNavigationBar:Container(
          color: Color(0xFF66101F),
          padding:EdgeInsets.fromLTRB(30, 10, 30, 30) ,
          child:
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavIcon(context, Icons.home, 'Home', const HomePage(), false),
            _buildNavIcon(context, Icons.analytics, 'Statistics', const ProfilePage(), false),
            _buildNavIcon(context, Icons.hiking, 'Hikes', const HikesPage(), true),
            _buildNavIcon(context, Icons.emoji_events_rounded, 'Achievements', const AchievementsPage(), false),
            _buildNavIcon(context, Icons.settings, 'Settings', const SettingsPage(), false),
          ],
        ),
      ),
    );
  } //build
} //SettingPage

Widget _buildNavIcon(BuildContext context, IconData icon, String tooltip, Widget page, bool isSelected) {
    return IconButton(
      icon: Icon(icon),
      tooltip: tooltip,
      color: isSelected ? const Color(0xFFDE7C5A) : const Color(0xFFFFF1D7),
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      },
    );
  }

