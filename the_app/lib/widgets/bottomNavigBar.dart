import 'package:flutter/material.dart';
import 'package:the_app/screens/achievementsPage.dart';
import 'package:the_app/screens/hikesPage.dart';
import 'package:the_app/screens/homePage.dart';
import 'package:the_app/screens/profilePage.dart';
import 'package:the_app/screens/settingsPage.dart';

class BottomNavigBar extends StatelessWidget {
  const BottomNavigBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(

      color: Theme.of(context).appBarTheme.titleTextStyle?.color,//Color(0xFF66101F),
      padding:EdgeInsets.fromLTRB(30, 10, 30, 30) ,
      child:
      Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon:
          Icon(Icons.home),
          tooltip: 'Home',
          color: Theme.of(context).textTheme.labelLarge?.color, //const Color(0xFFFFF1D7),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
            );
          },
        ),
        IconButton(
          icon:
          Icon(Icons.analytics),
          tooltip: 'Statistics',
          color:  Theme.of(context).textTheme.labelLarge?.color, //const Color(0xFFFFF1D7),
          onPressed: (){
            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfilePage()),
                );
          },
        ),
        IconButton(
          icon:
          Icon(Icons.hiking),
          tooltip: 'Hikes',
          color:  Theme.of(context).textTheme.labelLarge?.color, //const Color(0xFFFFF1D7),
          onPressed: (){
            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HikesPage()),
                );
          },
        ),
        IconButton(
          icon:
          Icon(Icons.emoji_events_rounded),
          tooltip: 'Achievements',
          color: Theme.of(context).textTheme.labelLarge?.color, // const Color(0xFFFFF1D7),
          onPressed: (){
            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AchievementsPage()),
                );
          },
        ),
        IconButton(
          icon: Icon(Icons.settings),
          tooltip: 'Settings',
          color: Theme.of(context).textTheme.labelLarge?.color, // const Color(0xFFFFF1D7),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsPage()),
            );
          },
        )
      ],
    ),);
  }
}