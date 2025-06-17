import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:the_app/screens/homePage.dart';
import 'package:the_app/screens/achievementsPage.dart';
import 'package:the_app/screens/hikesPage.dart';
import 'package:the_app/screens/profilePage.dart';
import 'package:the_app/screens/settingsPage.dart';
import 'package:the_app/data/hike.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:the_app/widgets/bottomNavigBar.dart';
import 'package:the_app/screens/thisHikePage.dart';




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
    Icon getIcon(Hike hike){
      if(hike.favourite == true){
          return Icon(Icons.favorite);
      } else {
        return Icon(Icons.favorite_border);
      }
    };
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(8, 50, 8, 8),
              child: Column( children: [Text('How much time do you have?', style: TextStyle(fontSize: 25, color: Color(0xFF66101F))), Text('Travel time included', style: TextStyle(fontSize: 20, color: Color(0xFF66101F), fontStyle: FontStyle.italic))])
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
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => Thishikepage(hike: hike)),
                          ).then((result){setState((){});});
                      },
                      trailing: IconButton(
                        icon: getIcon(hike),
                        color: Theme.of(context).textTheme.titleLarge?.color,
                        onPressed: () => {
                          setState(() {
                            hike.favourite = !hike.favourite;
                          })
                        },
                      ),
                    ),
                  ),
                );
              }),
            )
          ],
        )
      ),
      bottomNavigationBar:BottomNavigBar(currentPage: CurrentPage.hikes)
    );
  } //build
} //SettingPage


