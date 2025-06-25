import 'package:flutter/material.dart';
import 'package:the_app/widgets/bottomNavigBar.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:the_app/widgets/barChart.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Profile Page'), actions: [
      //    IconButton(
      //      icon: Image.asset('lib/pictures/logo simple.png'),
      //      onPressed: (){Navigator.pop(context);},
      //    ),
      //  ],),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(5, 75, 5, 5),
              child: Text(
                'Dive into your stats',
                style: TextStyle(color: Color(0xFF66101F), fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),
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
