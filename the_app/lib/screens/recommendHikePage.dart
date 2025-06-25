import 'package:flutter/material.dart';
import 'package:the_app/widgets/bottomNavigBar.dart';



class Recommendhikepage extends StatelessWidget {
  const Recommendhikepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('recommended hike'),
      ),
      bottomNavigationBar:BottomNavigBar(currentPage: CurrentPage.hikes)
    );
  } //build
} //SettingPage