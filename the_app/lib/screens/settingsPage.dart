import 'package:flutter/material.dart';
import 'package:the_app/screens/testPage.dart';
import 'package:the_app/widgets/logoutButton.dart';
import 'package:flutter/cupertino.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Setting Page'), actions: [
          IconButton(
            icon: Image.asset('lib/pictures/logo simple.png'),
            onPressed: (){Navigator.pop(context);},
          ),
        ],),
      body: Center(
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.person_pin_rounded, size: 90),Text("Welcome,\nJane Doe", style: TextStyle(fontSize: 30), textAlign: TextAlign.left,)]),
            Container(
                padding: EdgeInsets.fromLTRB(30, 30, 30, 50),
                child: Text("add here: toggle to define beginning of week"),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(30, 30, 30, 50),
                child: Text("add here: textbox to change weekly goal"),
            ),
            ElevatedButton(
              child: Text('To the home'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),

            LogoutButton(),

            ElevatedButton(
              child: Text('To the test page'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TestPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  } //build
} //SettingPage
