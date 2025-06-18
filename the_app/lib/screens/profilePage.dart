import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:the_app/widgets/bottomNavigBar.dart';
import 'dart:async';
import 'package:the_app/data/hike.dart';



class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>{
  // taken from https://www.geeksforgeeks.org/how-to-create-a-stopwatch-app-in-flutter/
  late Stopwatch stopwatch;
  late Timer t;
  
  @override
  void initState() {
    super.initState();
    stopwatch = Stopwatch();
    t = Timer.periodic(Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
    print("INIT state CALLED");
  }
  String buttontitle = "Start stopwatch";
  void handleStartStop() {
    if(stopwatch.isRunning) {
      stopwatch.stop();
      buttontitle = "Start stopwatch";
    }
    else {
      stopwatch.start();
      buttontitle = "Stop stopwatch";
    }
  }
  List<String> all_hikes = hike_names();
  String? _chosenHike = "Sentiero del Monte Cecilia";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(5, 75, 5, 5),
              child: Text(
                'Time your Hike',
                style: TextStyle(color: Color(0xFF66101F), fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(5, 75, 5, 5),
              child: Text(
                'Which hike are you walking?',
                style: TextStyle(color: Color(0xFF66101F), fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            DropdownButton<String>(
              value: _chosenHike,
              items: all_hikes.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _chosenHike = newValue;
                });
              },
              hint: Text(
                "Choose a Car Model",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Card(
            elevation: 8.0,
            margin: const EdgeInsets.all(50.0),
            child: Container(
              decoration: BoxDecoration(color: Theme.of(context).textTheme.labelMedium?.color),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                title: Text(buttontitle, style: const TextStyle(color: Colors.white, fontSize:20),textAlign: TextAlign.center,),
                onTap: (){
                  handleStartStop();
                },
              ),
            ),
          ),
          Text("${stopwatch.elapsed}"),
          Card(
            elevation: 8.0,
            margin: const EdgeInsets.all(50.0),
            child: Container(
              decoration: BoxDecoration(color: Theme.of(context).textTheme.labelMedium?.color),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                title: Text("Reset timer", style: const TextStyle(color: Colors.white, fontSize:20),textAlign: TextAlign.center,),
                onTap: (){
                  stopwatch.reset();
                },
              ),
            ),
          ),
          Card(
            elevation: 8.0,
            margin: const EdgeInsets.all(50.0),
            child: Container(
              decoration: BoxDecoration(color: Theme.of(context).textTheme.labelMedium?.color),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                title: Text("Save hike result", style: const TextStyle(color: Colors.white, fontSize:20),textAlign: TextAlign.center,),
                onTap: (){
                  handleStartStop();
                },
              ),
            ),
          ),
          ],
        ), 
      ),
      bottomNavigationBar:BottomNavigBar(currentPage: CurrentPage.profile),
    );
  } //build
} //ProfilePage

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
