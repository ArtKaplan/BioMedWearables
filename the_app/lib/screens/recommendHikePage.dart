import 'package:flutter/material.dart';
import 'package:the_app/widgets/bottomNavigBar.dart';
import 'package:the_app/data/hike.dart';
import 'package:the_app/provider/stepsProvider.dart';
import 'package:provider/provider.dart';
import 'package:the_app/screens/thisHikePage.dart';
import 'package:the_app/provider/settings_provider.dart';

Icon getIcon(Hike hike){
      if(hike.favourite == true){
          return Icon(Icons.favorite);
      } else {
        return Icon(Icons.favorite_border);
      }
    }

double getDeficit(steps, goal) {
  double total = 0;
  int count = 0;

  for (int i = steps.length - 1; count < 7; i--, count++) {
    if (i >= 0) { // negative if not enough elements
      total += steps[i].value;
    } else {
      total += 0; 
    }
  }

  return goal * 7 - total;
}

Hike getHike(deficit, stepLength){
  double difference = 100000;
  double newDifference = 0;
  Hike bestHike = hikelist[1];
  for(var i = 0; i<hikelist.length; i++){
    int steps = hikelist[i].distance * 1000 ~/ stepLength;
    newDifference = steps.toDouble() - deficit;
    if(newDifference.abs() < difference.abs()){
      bestHike = hikelist[i];
      difference = newDifference.abs();
    }
  }
  return bestHike;
}

class Recommendhikepage extends StatefulWidget {
  const Recommendhikepage({super.key});

  @override
  State<Recommendhikepage> createState() => _Recommendhikepage();
}

class _Recommendhikepage extends State<Recommendhikepage>{
  @override
  void initState() {
    super.initState();

    // Update steps when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StepsProvider>().getStepsEachDay();
    });
  }  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
             Container(
              padding: EdgeInsets.fromLTRB(5, 75, 5, 5),
              child: Text(
                'Do this hike to reach your weekly goal:',
                style: TextStyle(color: Theme.of(context).textTheme.titleLarge?.color, fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),
            Consumer<StepsProvider>(
              builder: (context, stepsProvider, _) {
                double stepLength = Provider.of<SettingsProvider>(context).stepLength! / 100;
                return FutureBuilder<dynamic>(
                  future: stepsProvider.getStepsEachDay(),
                  builder: (context, snapshot) {
                    int stepGoal = Provider.of<SettingsProvider>(context).goal;
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const CircularProgressIndicator();
                    }
                    if(!snapshot.hasData || snapshot.data==0){
                      return const Text("step data not available.");
                    }
                    double deficit = getDeficit(snapshot.data!, stepGoal); // change this to snapshot.data, this still doesn't work :////
                    if(deficit>=0){
                      Hike recommendedHike = getHike(deficit, stepLength);
                    return Card(
                      elevation: 8.0,
                      margin: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(color: const Color(0xFFDE7C5A)),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          title: Text(recommendedHike.name, style: const TextStyle(color: Color(0xFFFFF1D7), fontWeight: FontWeight.bold),),
                          subtitle:Text('Distance: '+recommendedHike.distance.toString()+' km, Duration: '+recommendedHike.duration + ', Steps: ${recommendedHike.distance * 1000 ~/ stepLength}'+'\nTravel time from Padova station: '+recommendedHike.traveltime, style: const TextStyle(color: Color(0xFFFFF1D7), fontStyle: FontStyle.italic),),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => Thishikepage(hike: recommendedHike)),
                              ).then((result){setState((){});});
                          },
                          trailing: IconButton(
                            icon: getIcon(recommendedHike),
                            color: Theme.of(context).textTheme.titleLarge?.color,
                            onPressed: () => {
                              setState(() {
                                recommendedHike.favourite = !recommendedHike.favourite;
                              })
                            },
                          ),
                        ),
                      ),
                    );
                    }else{
                      return Column(mainAxisAlignment: MainAxisAlignment.center, children: [Container(height:15),Icon(const IconData(0xe149, fontFamily: 'MaterialIcons'), size: 75,color:Theme.of(context).textTheme.titleLarge?.color ),Container(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30), child:(Text("You've reached your weekly goal! \nYou're all set!", style: TextStyle(fontSize: 20))))]);
                    }
                  },
                );
              },
            ),
          ]
        )
      ),
      bottomNavigationBar:BottomNavigBar(currentPage: CurrentPage.hikes)
    );
  } //build
} //SettingPage