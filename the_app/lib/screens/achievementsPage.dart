import 'package:flutter/material.dart';
import 'package:the_app/widgets/homeButton.dart';
import 'package:the_app/screens/homePage.dart';
import 'package:the_app/screens/settingsPage.dart';
import 'package:the_app/screens/hikesPage.dart';
import 'package:the_app/screens/profilePage.dart';
import 'package:the_app/widgets/bottomNavigBar.dart';


class AchievementsPage extends StatelessWidget {
  const AchievementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Achievements Page')),
      body: Center(
        child: Text('Achievements'),
      ),
      bottomNavigationBar:BottomNavigBar()
    );
  } //build
} //HikePage
