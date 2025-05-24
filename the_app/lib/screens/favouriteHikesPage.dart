import 'package:flutter/material.dart';
import 'package:the_app/screens/homePage.dart';
import 'package:the_app/screens/achievementsPage.dart';
import 'package:the_app/screens/hikesPage.dart';
import 'package:the_app/screens/profilePage.dart';
import 'package:the_app/screens/settingsPage.dart';
import 'package:the_app/widgets/bottomNavigBar.dart';



class FavouriteHikesPage extends StatelessWidget {
  const FavouriteHikesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Favourite hikes'),
      ),
      bottomNavigationBar:BottomNavigBar()
    );
  } //build
} //SettingPage

