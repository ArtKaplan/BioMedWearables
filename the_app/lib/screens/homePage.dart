import 'package:flutter/material.dart';
import 'package:the_app/screens/profilePage.dart';
import 'package:the_app/screens/settingsPage.dart';
import 'package:the_app/screens/hikesPage.dart';
import 'package:the_app/utils/loginStatus.dart';
import 'package:the_app/screens/sessionExpiredPage.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<LoginStatus> _checkStatus() => checkLoginStatus();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LoginStatus>(
      future: _checkStatus(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.data == LoginStatus.expired) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const SessionExpiredPage()),
              (route) => false,
            );
          });
          return const SizedBox();// empty placeholder
        }

        return _buildHomeScreen(context);// the normal homescreen, when logged in
      },
    );
  }

  Widget _buildHomeScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'), 
      ),
      body: SingleChildScrollView(
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
           Image.asset('lib/pictures/logo.png'),
           Container(padding: EdgeInsets.fromLTRB(30, 30, 30, 50), child: Text('Welcome, Jane Doe! \n Today\'s goal:', style: TextStyle(fontSize: 30,color: Color(0xFF66101F)), textAlign: TextAlign.center,)),
           SfRadialGauge(axes: <RadialAxis>[
                      RadialAxis(
                        minimum: 0,
                        maximum: 10000, // this should become the provider of the step goal
                        showLabels: false,
                        showTicks: false,
                        axisLineStyle: AxisLineStyle(
                          thickness: 0.2,
                          cornerStyle: CornerStyle.bothCurve,
                          color: Color(0xFFDE7C5A),
                          thicknessUnit: GaugeSizeUnit.factor,
                        ),
                        pointers: <GaugePointer>[
                          RangePointer(
                          value: 8056, // this should become the provider of the amount stepped today
                          cornerStyle: CornerStyle.bothCurve,
                          width: 0.2,
                          sizeUnit: GaugeSizeUnit.factor,
                          color: Color(0xFF66101F),
                          )
                          ],
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(
                          positionFactor: 0,
                          angle: 90,
                          widget: Text(
                          ' 8056 / 10000', // this should become amount stepped today / goal
                          style: TextStyle(fontSize: 30, color: Color(0xFF66101F),),
                          ))
                          ],
                      )
                    ]),   
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                ElevatedButton(
                  child: const Text('To the profile'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ProfilePage()),
                    );
                  },
                ),

                ElevatedButton(
                  child: const Text('To the hikes'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const HikesPage()),
                    );
                  },
                ),

                ElevatedButton(
                  child: const Text('To the settings'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SettingsPage()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

