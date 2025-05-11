import 'package:flutter/material.dart';
import 'package:the_app/screens/testPage.dart';
import 'package:the_app/widgets/homeButton.dart';
import 'package:the_app/widgets/logoutButton.dart';
import 'package:the_app/screens/homePage.dart';
import 'package:the_app/screens/achievementsPage.dart';
import 'package:the_app/screens/hikesPage.dart';
import 'package:the_app/screens/profilePage.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Setting Page'), actions: [
          IconButton(
            icon: Image.asset('lib/pictures/logo simple.png'),
            onPressed: (){Navigator.pop(context);},
          ),
        ],),
      body: Center(
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.person_pin_rounded, size: 90,),Text("Jane Doe", style: TextStyle(fontSize: 30), textAlign: TextAlign.left,), ],),
            Container(
                padding: EdgeInsets.fromLTRB(30, 30, 30, 50),
                child: Text("add here: toggle to define beginning of week"),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(30, 30, 30, 50),
                child: Text("add here: textbox to change weekly goal"),
            ),

            HomeButton(),

            LogoutButton(),

            ElevatedButton(
              child: Text('To the test page'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TestPage()),
                );
              },
            ),
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
              color:  const Color(0xFFFFF1D7),
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
              color:  const Color(0xFFDE7C5A),
              onPressed: (){
              },
            )
          ],
        ),
      ),
    );
  } //build
} //SettingPage
