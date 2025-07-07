import 'package:flutter/material.dart';
import 'package:the_app/data/hike.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:the_app/widgets/BarChart.dart';
import 'package:the_app/provider/hiketracking_provider.dart';
import 'package:provider/provider.dart';
import 'package:the_app/provider/settings_provider.dart';
import 'package:the_app/screens/timerPage.dart';



class Hikedescrpage extends StatelessWidget {
  final Hike hike;
  const Hikedescrpage({super.key, required this.hike});

  @override
  Widget build(BuildContext context) {
    final hikeStats = context.watch<HikeTracker>().getDetailedTimesForHike(hike.name);
    print('hikeStats = $hikeStats');

    double step_length = Provider.of<SettingsProvider>(context).stepLength! / 100;

    //data for BarCharts - Duration, Difficullty
    final List<String> x_Index = hikeStats.map((e) => e['index'].toString()).toList();
    final List<double> y_Duration = hikeStats.map((e) => (e['duration'] as Duration).inSeconds / 3600).toList(); //convert. from sec to h
    final List<double> y_Diffiulty = hikeStats.map((e) {
      final value = e['difficulty'];
      if (value is num) {
        return value.toDouble();
      } else if (value is String) {
        return double.tryParse(value) ?? 0.0;
      } else {
        return 0.0;
      }
    }).toList();

    if(hike.times.length == 0){
      return  SingleChildScrollView(
      child: Container(
      margin: const EdgeInsets.fromLTRB(50, 0, 50, 50),
      alignment: Alignment(0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              child: Image.asset(hike.image),
            ),
          Container(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Text(
                'About this hike',
                style: TextStyle(color: Color(0xFF66101F), fontSize: 20),
              ),
            ),
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(text: 'Hiking distance: ', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text: '${hike.distance} km (including transfer from train/bus station to hike)',
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
                  text: '${hike.duration} (including transfer from train/bus station to hike)',
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
                  text: '${hike.distance * 1000 ~/ step_length}',
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
                    decoration: BoxDecoration(color: Theme.of(context).textTheme.labelMedium?.color),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      title: Text('See full hike at Komoot', style: const TextStyle(color: Colors.white),),
                      onTap: () async{
                        await launchUrl(Uri.parse(hike.url));
                      },
                    ),
                  ),
          ),
          Card(
            elevation: 8.0,
                  child: Container(
                    decoration: BoxDecoration(color: Theme.of(context).textTheme.titleLarge?.color),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      title: Text('Register this hike', style: const TextStyle(color: Colors.white),),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => TimerPage(preselected_hike: hike.name)),
                          );
                      },
                    ),
                  ),
          ),
        Container(
              padding: EdgeInsets.fromLTRB(5, 15, 5, 5),
              child: Text(
                'Check your stats',
                style: TextStyle(color: Theme.of(context).textTheme.titleLarge?.color, fontSize: 20),
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
              child: Image.asset(hike.image),
            ),
          Container(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: Text(
                'About this hike',
                style: TextStyle(color: Color(0xFF66101F), fontSize: 20),
              ),
            ),
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(text: 'Hiking distance: ', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text: '${hike.distance} km (including transfer from train/bus station to hike)',
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
                  text: '${hike.duration} (including transfer from train/bus station to hike)',
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
                  text: '${hike.distance * 1000 ~/ step_length}',
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
                    decoration: BoxDecoration(color: Theme.of(context).textTheme.labelMedium?.color),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      title: Text('See full hike at Komoot', style: const TextStyle(color: Colors.white),),
                      onTap: () async{
                        await launchUrl(Uri.parse(hike.url));
                      },
                    ),
                  ),
          ),
          Card(
            elevation: 8.0,
                  child: Container(
                    decoration: BoxDecoration(color: Theme.of(context).textTheme.titleLarge?.color),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      title: Text('Register this hike', style: const TextStyle(color: Colors.white),),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => TimerPage(preselected_hike: hike.name)),
                          );
                      },
                    ),
                  ),
          ),
        Container(
              padding: EdgeInsets.fromLTRB(5, 15, 5, 5),
              child: Text(
                'Check your stats',
                style: TextStyle(color: Theme.of(context).textTheme.titleLarge?.color, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
        SizedBox(height: 10),
        if (hikeStats.isEmpty)
          Text('You did not complete this hike yet!')
        else
          Table(
            border: TableBorder.all(color: Colors.grey),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: {
              0: FixedColumnWidth(50),
              1: FixedColumnWidth(110),
              2: FlexColumnWidth(),
            },
            children: [
              TableRow(
                decoration: BoxDecoration(color: Colors.grey[300]),
                children: [
                  Padding(
                      padding: EdgeInsets.all(8), child: Text('#', style: TextStyle(fontWeight: FontWeight.bold))),
                  Padding(
                      padding: EdgeInsets.all(8), child: Text('Date', style: TextStyle(fontWeight: FontWeight.bold))),
                  Padding(
                      padding: EdgeInsets.all(8), child: Text('Duration', style: TextStyle(fontWeight: FontWeight.bold))),
                ],
              ),
              ...hikeStats.map((e) {
                final dur = e['duration'] as Duration;
                final durText =
                    "${dur.inHours}h${(dur.inMinutes % 60).toString().padLeft(2, '0')}min${(dur.inSeconds % 60).toString().padLeft(2, '0')}s";
                return TableRow(children: [
                  Padding(padding: EdgeInsets.all(8), child: Text('${e['index']}')),
                  Padding(padding: EdgeInsets.all(8), child: Text(e['date'])),
                  Padding(padding: EdgeInsets.all(8), child: Text(durText)),
                ]);
              }).toList(),  
            ],
          ),
      
        RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(text: 'Well done! You have done this hike ${hikeStats.length} times already! \n', style: TextStyle(fontWeight: FontWeight.bold)),
                //TextSpan(text: 'Well done! You have done this hike ${hike.times.length} times already! \n', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text: 'Check out your stats for this hike below. How do you like your progress?',
                ),
              ],
            ),
          ),
        Container(height: 350, width : 350, padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),child:
          SimpleBarChart(xAxisList: x_Index, yAxisList: y_Duration, xAxisName: 'Hike #', yAxisName: 'Time [h]', interval: 1),          
          //SimpleBarChart(xAxisList: getAxisListTime()[0], yAxisList: getAxisListTime()[1], xAxisName: 'Hike #', yAxisName: 'Time [h]', interval: 1),
        ),
        Container(height: 350, width : 350, padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),child:
          SimpleBarChart(xAxisList: x_Index, yAxisList: y_Diffiulty, xAxisName: 'Hike #', yAxisName: 'Difficulty', interval: 1),
          //SimpleBarChart(xAxisList: getAxisListDiff()[0], yAxisList: getAxisListDiff()[1], xAxisName: 'Hike #', yAxisName: 'Difficulty', interval: 1),
        ),
        ],
      ),
      )
    );
    }
  }
}