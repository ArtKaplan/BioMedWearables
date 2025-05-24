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
      //appBar: AppBar(title: Text('Achievements Page')),
      body: Column(
        children: [    
          Container(
              padding: EdgeInsets.fromLTRB(5, 75, 5, 5),
              child: Text(
                'Keep it up!',
                style: TextStyle(color: Color(0xFF66101F), fontSize: 25),
                textAlign: TextAlign.center,
              ),
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
