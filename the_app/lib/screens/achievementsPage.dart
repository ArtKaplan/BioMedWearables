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
      body: Column(
        children: [    
          Container(
            padding: const EdgeInsets.fromLTRB(8, 50, 8, 8),
            child: Text('Keep it up!', style: TextStyle(fontSize: 25, color: Color(0xFF66101F)))
          ),        
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Column(children: [
                Text("20", style: TextStyle(fontSize: 80)), // this 20 needs to be a streak amount
                Text("weeks of walking", style: TextStyle(fontSize: 20)),
              ],),
              Icon(Icons.local_fire_department, color: Colors.orange, size: 150.0,),
            ],),],
      ),
      bottomNavigationBar:BottomNavigBar(currentPage: CurrentPage.achievements)
    );
  } //build
} //HikePage
