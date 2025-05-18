import 'package:flutter/material.dart';
import 'package:the_app/screens/homePage.dart';
import 'package:the_app/screens/achievementsPage.dart';
import 'package:the_app/screens/hikesPage.dart';
import 'package:the_app/screens/profilePage.dart';
import 'package:the_app/screens/settingsPage.dart';
import 'package:the_app/data/hike.dart';
import 'package:url_launcher/url_launcher.dart';


class Allhikespage extends StatefulWidget {
  Allhikespage({super.key});

  @override
  State<Allhikespage> createState() => _AllhikespageState();
}

class _AllhikespageState extends State<Allhikespage>{

  final List<String> categories = [
    'short',
    'middle', 
    'long',
  ];

  final Map<String, String> categoryLabels = {
  'short': '< 4 hours',
  'middle': '4–6 hours',
  'long': '> 6 hours',
  };

  List<String> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    final filterHikes = hikelist.where((hike){
      return selectedCategories.isEmpty || selectedCategories.contains(hike.type);
    }).toList();
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(8, 50, 8, 8),
              child: Text('How much time do you have?', style: TextStyle(fontSize: 25, color: Color(0xFF66101F)))
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: categories
                .map((category)=>FilterChip(
                  label: Text(categoryLabels[category]!), 
                  selected: selectedCategories.contains(category),
                  backgroundColor: Color(0xFF66101F),
                  selectedColor: Color(0xFF66101F),
                  checkmarkColor: Colors.white,
                  labelStyle: TextStyle(color: Colors.white),
                  onSelected: (selected) {
                    setState((){
                      if (selected){
                        selectedCategories.add(category);
                      } else {
                        selectedCategories.remove(category);
                      }
                    });
                  }),
                )
                .toList(),
              ),
            ),
            Expanded(child: ListView.builder(
              itemCount: filterHikes.length,
              itemBuilder: (context,index){
                final hike = filterHikes[index];
                return Card(
                  elevation: 8.0,
                  margin: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(color: const Color(0xFFDE7C5A)),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      title: Text(hike.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      subtitle:Text('Distance: '+hike.distance.toString()+' km, Duration: '+hike.duration + ', Steps: '+hike.steps.toInt().toString()+'\nTravel time from Padova station: '+hike.traveltime, style: const TextStyle(color: Colors.white, fontStyle: FontStyle.italic),),
                      onTap: (){
                          //launchUrl(Uri.parse(hike.url));
                      },
                    ),
                  ),
                );
              }),
            )
          ],
        )
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

