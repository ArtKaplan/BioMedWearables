import 'package:flutter/material.dart';
import 'package:the_app/widgets/bottomNavigBar.dart';
import 'dart:async';
import 'package:the_app/data/hike.dart';
import 'package:provider/provider.dart';
import 'package:the_app/provider/hiketracking_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



class TimerPage extends StatefulWidget {
  final String preselected_hike;
  const TimerPage({super.key, this.preselected_hike = 'Sentiero del Monte Cecilia'});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage>{
  // taken from https://www.geeksforgeeks.org/how-to-create-a-stopwatch-app-in-flutter/
  late HikeTracker hikeProvider;
  late Stopwatch stopwatch;
  late Timer t;
  int extra = 0;
  bool pres_mode = false;
  String? _chosenHike;
  
  @override
  void initState() {
    super.initState();
    _chosenHike = widget.preselected_hike;
    SharedPreferences.getInstance().then((sp) {
      setState((){pres_mode = sp.getBool('presentation_mode') ?? false;});
      });
    hikeProvider = Provider.of<HikeTracker>(context, listen: false);
    stopwatch = Stopwatch();
    t = Timer.periodic(Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    t.cancel();
    super.dispose();
  }

  String buttontitle = "Start stopwatch";
  Color? buttoncolor = Color(0xFFDE7C5A);
  void handleStartStop() {
    if(stopwatch.isRunning) {
      stopwatch.stop();
      buttontitle = "Start stopwatch";
      buttoncolor = Theme.of(context).textTheme.labelMedium?.color;
    }
    else {
      stopwatch.start();
      buttontitle = "Stop stopwatch";
      buttoncolor = Theme.of(context).textTheme.titleLarge?.color;
    }
  }
  String getTime(Duration time, int extra){
    int sec = time.inSeconds.toInt() + extra;
    int hour = sec~/3600;
    sec = sec - hour*3600;
    int min = sec~/60;
    sec = sec - min*60;

    String output = hour.toString().padLeft(2, '0')+':'+min.toString().padLeft(2, '0')+':'+sec.toString().padLeft(2, '0');
    return output;
  }
  int getIndex(){
    for(var i=0;i<hikelist.length;i++){
      if(hikelist[i].name==_chosenHike){
        return i;
      }
    }
    int i = 0;
    return i;
  }
  double _currentValue = 0;
  Future getDifficulty() async{
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setStateDialog){
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min, 
                  children: [
                    Text('How tired are you after the hike?'),
                    Slider(
                      value: _currentValue,
                      max: 10,
                      divisions: 100,
                      label: _currentValue.toStringAsFixed(1),
                      onChanged: (double value) {
                        setStateDialog(() {
                          _currentValue = value;
                        });
                      },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0), // Anpassbarer Abstand
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Easy'),  // left end
                      Text('Hard'),  //right end
                    ],
                  ),
                ),
                ]),
                actions: <Widget>[
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop(_currentValue);
                    },
                  ),
                ],
              );
            },
          );
        },
      );
  }
  void saveResult(){
    if(stopwatch.isRunning){
      showDialog( // taken from https://www.dhiwise.com/post/how-to-build-customizable-pop-ups-with-flutter-dialog
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('First stop the stopwatch'),
            actions: <Widget>[
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      int index = getIndex();
      showDialog( // taken from https://www.dhiwise.com/post/how-to-build-customizable-pop-ups-with-flutter-dialog
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('Are you sure that you want to save your time of ${stopwatch.elapsed + Duration(seconds:extra)} to Hike "${hikelist[index].name}"?'),
            actions: <Widget>[
              TextButton(
                child: Text('Yes'),
                onPressed: () async {
                  final duration = stopwatch.elapsed+ Duration(seconds:extra);
                  setState((){
                    hikelist[index].times.add(stopwatch.elapsed+ Duration(seconds:extra));
                  });
                  stopwatch.reset();
                  t.cancel();
                  Navigator.of(context).pop();
                  double difficulty = await getDifficulty();
                  setState((){
                    hikelist[index].difficulties.add(difficulty);
                  });
                  await hikeProvider.saveCompletedHike(_chosenHike!, duration, difficulty);
                  
                },
              ),
              TextButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
  List<String> all_hikes = hike_names();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(height:150, child:Image.asset('lib/pictures/logo.png')),
            Container(
              padding: EdgeInsets.fromLTRB(5, 20, 5, 5),
              child: Text(
                'Time your Hike',
                style: TextStyle(color: Theme.of(context).textTheme.titleLarge?.color, fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),
            Card(
            elevation: 8.0,
            margin: const EdgeInsets.all(30.0),
            child: Container(
              decoration: BoxDecoration(color: buttoncolor),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                title: Text(buttontitle, style: const TextStyle(color: Color(0xFFFFF1D7),fontSize:20),textAlign: TextAlign.center,),
                onTap: (){
                  handleStartStop();
                },
              ),
            ),
          ),
          Text(getTime(stopwatch.elapsed, extra)),
          Card(
            elevation: 8.0,
            margin: const EdgeInsets.all(30.0),
            child: Container(
              decoration: BoxDecoration(color: Theme.of(context).textTheme.labelMedium?.color),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                title: Text("Reset stopwatch", style: const TextStyle(color: Color(0xFFFFF1D7), fontSize:20),textAlign: TextAlign.center,),
                onTap: (){
                  extra = 0;
                  stopwatch.reset();
                },
              ),
            ),
          ),
          if(pres_mode)
            ElevatedButton.icon(onPressed: (){setState((){extra = extra+900;});}, label: Text("Add 15 minutes"),icon: const Icon(Icons.align_vertical_bottom)),
          Container(
              padding: EdgeInsets.fromLTRB(5, 30, 5, 5),
              child: Text(
                'Which hike are you doing?',
                style: TextStyle(color: Theme.of(context).textTheme.titleLarge?.color, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            DropdownButton<String>(
              value: _chosenHike,
              dropdownColor: Theme.of(context).textTheme.labelLarge?.color,
              style: TextStyle(color:Theme.of(context).textTheme.titleLarge?.color),
              items: all_hikes.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _chosenHike = newValue;
                });
              },
              hint: Text(
                "Choose a Hike",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          Card(
            elevation: 8.0,
            margin: const EdgeInsets.all(30.0),
            child: Container(
              decoration: BoxDecoration(color: Theme.of(context).textTheme.labelMedium?.color),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                title: Text("Save hike result", style: const TextStyle(color: Color(0xFFFFF1D7), fontSize:20),textAlign: TextAlign.center,),
                onTap: (){
                  saveResult();
                },
              ),
            ),
          ),
          ],
        ), 
      ),
      bottomNavigationBar:BottomNavigBar(currentPage: CurrentPage.profile),
    );
  } //build
} //TimerPage