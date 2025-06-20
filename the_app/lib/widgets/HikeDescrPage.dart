import 'package:flutter/material.dart';
import 'package:the_app/data/hike.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:the_app/widgets/BarChart2.dart';

class Hikedescrpage extends StatelessWidget {
  final Hike hike;
  const Hikedescrpage({super.key, required this.hike});

  @override
  Widget build(BuildContext context) {
    List getAxisListTime(){
      List AxisList = [];
      List<String> AxisListx = [];
      List<double> AxisListy =[];
      AxisList.add(AxisListx);
      AxisList.add(AxisListy);
      for (var i = 0; i<hike.times.length; i++){
        AxisList[0].add(i.toString());
        AxisList[1].add(hike.times[i].inSeconds.toDouble()); // [REMINDER] UNDO THIS: THIS MUST BE HOURS, only for debugging purposes in seconds
      }
      return AxisList;
    }
    List getAxisListDiff(){
      List AxisList = [];
      List<String> AxisListx = [];
      List<double> AxisListy =[];
      AxisList.add(AxisListx);
      AxisList.add(AxisListy);
      for (var i = 0; i<hike.difficulties.length; i++){
        AxisList[0].add(i.toString());
        AxisList[1].add(hike.difficulties[i]); // [REMINDER] UNDO THIS: THIS MUST BE HOURS, only for debugging purposes in seconds
      }
      return AxisList;
    }
    if(hike.times.length == 0){
      return  SingleChildScrollView(
      child: Container(
      margin: const EdgeInsets.all(50.0),
      alignment: Alignment(0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
              child: Text(
                'About this hike',
                style: TextStyle(color: Color(0xFF66101F), fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(text: 'Distance: ', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text: '${hike.distance}',
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(text: 'Estimated duration: ', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text: '${hike.duration}',
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(text: 'Estimated amount of steps : ', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text: '${hike.steps}',
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(text: 'How to get there: \n', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text: '${hike.route} \n',
                ),
              ],
            ),
          ),
          Card(
            elevation: 8.0,
                  child: Container(
                    decoration: BoxDecoration(color: Theme.of(context).textTheme.labelMedium?.color),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      title: Text('Google Maps route to the starting point', style: const TextStyle(color: Colors.white),),
                      onTap: () async{
                        await launchUrl(Uri.parse(hike.maps));
                      },
                    ),
                  ),
          ),
          Card(
            elevation: 8.0,
                  child: Container(
                    decoration: BoxDecoration(color:  Color(0xFF66101F)),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      title: Text('See full hike at Komoot', style: const TextStyle(color: Colors.white),),
                      onTap: () async{
                        await launchUrl(Uri.parse(hike.url));
                      },
                    ),
                  ),
          ),
        Container(
              padding: EdgeInsets.fromLTRB(5, 15, 5, 5),
              child: Text(
                'Check your stats',
                style: TextStyle(color: Color(0xFF66101F), fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
        RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(text: 'You haven\'t done this hike yet\n', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text: 'Record your hike to gain insights.',
                ),
              ],
            ),
          ),
        ],
      ),
      )
    );

    }else{
      return  SingleChildScrollView(
      child: Container(
      margin: const EdgeInsets.all(50.0),
      alignment: Alignment(0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
              child: Text(
                'About this hike',
                style: TextStyle(color: Color(0xFF66101F), fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(text: 'Distance: ', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text: '${hike.distance}',
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(text: 'Estimated duration: ', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text: '${hike.duration}',
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(text: 'Estimated amount of steps : ', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text: '${hike.steps}',
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(text: 'How to get there: \n', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text: '${hike.route} \n',
                ),
              ],
            ),
          ),
          Card(
            elevation: 8.0,
                  child: Container(
                    decoration: BoxDecoration(color: Theme.of(context).textTheme.labelMedium?.color),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      title: Text('Google Maps route to the starting point', style: const TextStyle(color: Colors.white),),
                      onTap: () async{
                        await launchUrl(Uri.parse(hike.maps));
                      },
                    ),
                  ),
          ),
          Card(
            elevation: 8.0,
                  child: Container(
                    decoration: BoxDecoration(color:  Color(0xFF66101F)),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      title: Text('See full hike at Komoot', style: const TextStyle(color: Colors.white),),
                      onTap: () async{
                        await launchUrl(Uri.parse(hike.url));
                      },
                    ),
                  ),
          ),
        Container(
              padding: EdgeInsets.fromLTRB(5, 15, 5, 5),
              child: Text(
                'Check your stats',
                style: TextStyle(color: Color(0xFF66101F), fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
        RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(text: 'Well done! You have done this hike ${hike.times.length} times already! \n', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text: 'Check out your stats for this hike below. How do you like your progress?',
                ),
              ],
            ),
          ),
        Container(height: 350, width : 350, padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),child:
          SimpleBarChart(xAxisList: getAxisListTime()[0], yAxisList: getAxisListTime()[1], xAxisName: 'Hike #', yAxisName: 'Time [h]', interval: 1),
        ),
        Container(height: 350, width : 350, padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),child:
          SimpleBarChart(xAxisList: getAxisListDiff()[0], yAxisList: getAxisListDiff()[1], xAxisName: 'Hike #', yAxisName: 'Difficulty', interval: 1),
        ),
        ],
      ),
      )
    );
    }
  }
}