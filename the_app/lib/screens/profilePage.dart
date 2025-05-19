import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:the_app/widgets/bottomNavigBar.dart';
import 'package:the_app/widgets/homeButton.dart';
import 'package:the_app/widgets/logoutButton.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:the_app/widgets/barChart.dart';
import 'package:the_app/screens/homePage.dart';
import 'package:the_app/screens/settingsPage.dart';
import 'package:the_app/screens/hikesPage.dart';
import 'package:the_app/screens/achievementsPage.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile Page'), actions: [
          IconButton(
            icon: Image.asset('lib/pictures/logo simple.png'),
            onPressed: (){Navigator.pop(context);},
          ),
        ],),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Column(children: [
                Text("20", style: TextStyle(fontSize: 80)), // this 20 needs to be a streak amount
                Text("weeks of walking", style: TextStyle(fontSize: 20)),
              ],),
              Icon(Icons.local_fire_department, color: Colors.orange, size: 150.0,),
            ],),
            BarChartSample3(), // must update based on the info of the past 7 days
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Column(
                children: [
                Text("30k", style: TextStyle(fontSize: 80)), // this needs to be weekly goal - sum of all steps from start of week up until now
                Text("steps removed of \n your weekly goal", style: TextStyle(fontSize: 20)),
              ],),
              SizedBox(
                height: 150,
                width: 150,
                child: 
                SfRadialGauge(axes: <RadialAxis>[
                        RadialAxis(
                          canScaleToFit: true,
                          minimum: 0,
                          maximum: 100,
                          showLabels: false,
                          showTicks: false,
                          startAngle: 270,
                          endAngle: 270,
                          axisLineStyle: AxisLineStyle(
                            thickness: 0.2,
                            cornerStyle: CornerStyle.bothCurve,
                            color: Color.fromARGB(30, 0, 169, 181),
                            thicknessUnit: GaugeSizeUnit.factor,
                          ),
                          pointers: <GaugePointer>[
                          RangePointer(
                              value: 75, // make dynamic
                              width: 0.2,
                              sizeUnit: GaugeSizeUnit.factor,
                              cornerStyle: CornerStyle.startCurve,
                              gradient: const SweepGradient(colors: <Color>[
                                Colors.orange,
                                Color.fromARGB(255, 255, 214, 127)
                              ], stops: <double>[
                                0.25,
                                0.75
                              ])),
                          MarkerPointer(
                            value: 75, // make dynamic
                            markerType: MarkerType.circle,
                            markerHeight: 25,
                            markerWidth: 25,
                            color: Colors.orange,
                            )
                          ],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                            positionFactor: 0,
                            angle: 90,
                            widget: Text(
                            '75%', // this should be the amount of steps stepped this week / weekly goal 
                            style: TextStyle(fontSize: 30),
                            ))
                            ],
                        )
                      ]), 
                ),  
            ],),

            HomeButton(),
            
            LogoutButton(),
          ],
        ),
        
      ),
      bottomNavigationBar:BottomNavigBar(),
    );
  } //build
} //ProfilePage
