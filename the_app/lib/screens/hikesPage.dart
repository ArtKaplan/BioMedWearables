import 'package:flutter/material.dart';
import 'package:the_app/screens/homePage.dart';
import 'package:the_app/screens/settingsPage.dart';
import 'package:the_app/screens/profilePage.dart';
import 'package:the_app/screens/achievementsPage.dart';
import 'package:the_app/screens/recommendHikePage.dart';
import 'package:the_app/screens/allHikesPage.dart';
import 'package:the_app/screens/favouriteHikesPage.dart';


class HikesPage extends StatelessWidget {
  const HikesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final titles = ['Surprise me', 'Discover the options', 'My own pickings'];
    final subtitles = ['Recommended hike', 'All hikes', 'Saved hikes'];
    final icons = [IconData(0xe37b, fontFamily: 'MaterialIcons'), IconData(0xe3c8, fontFamily: 'MaterialIcons') ,Icons.favorite];
    final nav = [Recommendhikepage(), Allhikespage(), FavouriteHikesPage()];

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(5, 75, 5, 5),
              child: Text(
                'Ready to reach your goal?',
                style: TextStyle(color: Color(0xFF66101F), fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: titles.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 8.0,
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Container(
                      decoration: const BoxDecoration(color: Color(0xFFDE7C5A)),
                      child: ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        title: Text(
                          titles[index],
                          style: const TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        subtitle: Text(
                          subtitles[index],
                          style: const TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        leading: Icon(icons[index], color: Color(0xFF66101F), size: 50),
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => nav[index]),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFF66101F),
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 30),
        child: Row(
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
  }

  Widget _buildNavIcon(BuildContext context, IconData icon, String tooltip, Widget page, bool isSelected) {
    return IconButton(
      icon: Icon(icon),
      tooltip: tooltip,
      color: isSelected ? const Color(0xFFDE7C5A) : const Color(0xFFFFF1D7),
      onPressed: () {
        if (!isSelected) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
        }
      },
    );
  }
}