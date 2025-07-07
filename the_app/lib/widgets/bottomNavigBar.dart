import 'package:flutter/material.dart';
import 'package:the_app/screens/achievementsPage.dart';
import 'package:the_app/screens/hikesPage.dart';
import 'package:the_app/screens/homePage.dart';
import 'package:the_app/screens/timerPage.dart';
import 'package:the_app/screens/settingsPage.dart';

enum CurrentPage { home, profile, hikes, achievements, settings}

class BottomNavigBar extends StatelessWidget {
  final CurrentPage currentPage;
  const BottomNavigBar({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    Color getIconColor(CurrentPage page) {
      if(currentPage == page){
          return Color(0xFFDE7C5A);
      } else {
        return Color(0xFFFFF1D7);
      }
    }
    return  Container(

      color: Color(0xFF66101F),//Color(0xFF66101F),
      padding:EdgeInsets.fromLTRB(30, 10, 30, 30) ,
      child:
      Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon:
          Icon(Icons.home),
          tooltip: 'Home',
          color: getIconColor(CurrentPage.home),
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
            );
          },
        ),
        IconButton(
          icon:
          Icon(const IconData(0xe662, fontFamily: 'MaterialIcons')),
          tooltip: 'Stopwatch',
          color:  getIconColor(CurrentPage.profile),
          onPressed: (){
            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TimerPage()),
                );
          },
        ),
        IconButton(
          icon:
          Icon(Icons.hiking),
          tooltip: 'Hikes',
          color: getIconColor(CurrentPage.hikes),
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
          color: getIconColor(CurrentPage.achievements),
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
          color:getIconColor(CurrentPage.settings),
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