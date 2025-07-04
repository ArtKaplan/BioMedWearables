import 'package:flutter/material.dart';
import 'package:the_app/widgets/bottomNavigBar.dart';
import 'package:the_app/data/hike.dart';
import 'package:the_app/provider/stepsProvider.dart';
import 'package:provider/provider.dart';
import 'package:the_app/screens/thisHikePage.dart';

Icon getIcon(Hike hike){
      if(hike.favourite == true){
          return Icon(Icons.favorite);
      } else {
        return Icon(Icons.favorite_border);
      }
    }

double getDeficit(steps, goal){
  double total = 0;
  for(var i=steps.length-1;i>steps.length-8; i--){
    total = total + steps[i];
  }
  return goal*7 - total;
}
Hike getHike(deficit){
  double difference = 100000;
  double new_difference = 0;
  Hike best_hike = hikelist[1];

  for(var i = 0; i<hikelist.length; i++){
    print(hikelist[i].name);
    print(hikelist[i].steps);
    new_difference = hikelist[i].steps.toDouble() - deficit;
    print(new_difference);
    if(new_difference.abs() < difference.abs()){
      best_hike = hikelist[i];
      print('OK');
    }
    difference = new_difference.abs();
  }
  return best_hike;
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
                return FutureBuilder<dynamic>(
                  future: stepsProvider.getStepsEachDay(),
                  builder: (context, snapshot) {
                    int step_goal = Provider.of<StepsProvider>(context).step_weeklyGoal;
                    double deficit = getDeficit(snapshot.data!, step_goal); // change this to snapshot.data, this still doesn't work :////
                    if(deficit>=0){
                      Hike recommended_hike = getHike(deficit);
                    return Card(
                      elevation: 8.0,
                      margin: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(color: const Color(0xFFDE7C5A)),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          title: Text(recommended_hike.name, style: const TextStyle(color: Color(0xFFFFF1D7), fontWeight: FontWeight.bold),),
                          subtitle:Text('Distance: '+recommended_hike.distance.toString()+' km, Duration: '+recommended_hike.duration + ', Steps: '+recommended_hike.steps.toInt().toString()+'\nTravel time from Padova station: '+recommended_hike.traveltime, style: const TextStyle(color: Color(0xFFFFF1D7), fontStyle: FontStyle.italic),),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => Thishikepage(hike: recommended_hike)),
                              ).then((result){setState((){});});
                          },
                          trailing: IconButton(
                            icon: getIcon(recommended_hike),
                            color: Theme.of(context).textTheme.titleLarge?.color,
                            onPressed: () => {
                              setState(() {
                                recommended_hike.favourite = !recommended_hike.favourite;
                              })
                            },
                          ),
                        ),
                      ),
                    );
                    }else{
                      return Column(mainAxisAlignment: MainAxisAlignment.center, children: [Container(height:15),Icon(IconData(0xe149, fontFamily: 'MaterialIcons'), size: 75,color:Theme.of(context).textTheme.titleLarge?.color ),Container(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30), child:(Text("You've reached your weekly goal! \nYou're all set!", style: TextStyle(fontSize: 20))))]);
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