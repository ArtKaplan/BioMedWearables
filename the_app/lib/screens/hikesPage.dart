import 'package:flutter/material.dart';
import 'package:the_app/widgets/bottomNavigBar.dart';
import 'package:the_app/widgets/homeButton.dart';

class HikesPage extends StatelessWidget {
  const HikesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hikes Page')),
      body: Center(
        child: Column(
          children: [
            HomeButton(),
          ],
        ),
      ),
    bottomNavigationBar: BottomNavigBar(),
    );
  } //build
} //HikePage
