import 'package:flutter/material.dart';
import 'package:the_app/data/hike.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class Hikedescrpage extends StatelessWidget {
  final Hike hike;
  const Hikedescrpage({super.key, required this.hike});

  @override
  Widget build(BuildContext context) {
    print('test');
    return  Container(
      margin: const EdgeInsets.all(50.0),
      alignment: Alignment(0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  text: hike.duration,
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
          )
        ],
      ),
    );
  }
}