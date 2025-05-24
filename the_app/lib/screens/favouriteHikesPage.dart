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



class FavouriteHikesPage extends StatefulWidget {
  FavouriteHikesPage({super.key});

  @override
  State<FavouriteHikesPage> createState() => _FavouritehikespageState();
}

class _FavouritehikespageState extends State<FavouriteHikesPage>{

  @override
  Widget build(BuildContext context) {
    final filterHikes = hikelist.where((hike)=>hike.favourite==true).toList();
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
              padding: const EdgeInsets.fromLTRB(30, 70, 15, 15),
              child: Text('Ready to (re)discover your favourite hikes?', style: TextStyle(fontSize: 25, color: Color(0xFF66101F)))
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
                      onTap: () async{
                        await launchUrl(Uri.parse(hike.url));
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


