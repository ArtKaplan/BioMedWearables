import 'package:flutter/material.dart';

class HikesPage extends StatelessWidget {
  const HikesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hikes Page')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: Text('To the home'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  } //build
} //HikePage
