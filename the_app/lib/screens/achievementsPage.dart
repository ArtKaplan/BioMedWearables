import 'package:flutter/material.dart';
import 'package:the_app/widgets/homeButton.dart';
import 'package:the_app/screens/homePage.dart';
import 'package:the_app/screens/settingsPage.dart';
import 'package:the_app/screens/hikesPage.dart';
import 'package:the_app/screens/profilePage.dart';

class AchievementsPage extends StatelessWidget {
  const AchievementsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Achievements Page')),
      body: Center(
        child: Column(
          children: [
            HomeButton(),
          ],
        ),
      ),
      bottomNavigationBar:Container(
          color: Color(0xFF66101F),
          padding:EdgeInsets.fromLTRB(30, 10, 30, 30) ,
          child:
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon:
              Icon(Icons.home),
              tooltip: 'Home',
              color:  const Color(0xFFFFF1D7),
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
              color:  const Color(0xFFFFF1D7),
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
              color:  const Color(0xFFFFF1D7),
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
              color:  const Color(0xFFDE7C5A),
              onPressed: (){
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              tooltip: 'Settings',
              color:  const Color(0xFFFFF1D7),
              onPressed: (){Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SettingsPage()),
                    );},
            )
          ],
        ),
      ),
    );
  } //build
} //HikePage
