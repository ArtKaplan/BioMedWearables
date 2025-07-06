import 'package:flutter/material.dart';
import 'package:the_app/widgets/BarChart2.dart';
import 'package:provider/provider.dart';
import 'package:the_app/provider/stepsProvider.dart';
import 'package:the_app/provider/settings_provider.dart';
import 'package:the_app/widgets/DeficitWeek.dart';

List<double> getSteps(steps){
  List<double> total = [];
  int count = 0;
  for (int i = steps.length - 1; count < 7; i--, count++) {
    if (i >= 0) { // negative if not enough elements
      total.add(steps[i].value.toDouble());
    } else {
      total.add(0); 
    }
  }
  return total;
}

getDeficit(steps,goal){
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

List<String> getDate(){
  final Map<int, String> weekdays = {
  1:'Mon',
  2: 'Tue',
  3: 'Wed',
  4: 'Thu',
  5: 'Fri',
  6: 'Sat',
  7: 'Sun'
  };
  DateTime now = DateTime.now(); // https://medium.com/@muhvarriel/finding-and-showing-this-weeks-dates-in-flutter-aa81e4852ec9
  int currentWeekday = now.weekday;
  
  return [weekdays[(currentWeekday + 1)%7+1]!, weekdays[(currentWeekday + 2)%7+1]!, weekdays[(currentWeekday + 3)%7+1]!, weekdays[(currentWeekday + 4)%7+1]!, weekdays[(currentWeekday + 5)%7+1]!, weekdays[(currentWeekday + 6)%7+1]!, weekdays[(currentWeekday)]!];
}

class Achievementsbarchart extends StatefulWidget {
  const Achievementsbarchart({super.key});

  @override
  State<Achievementsbarchart> createState() => _Achievementsbarchart();
}

class _Achievementsbarchart extends State<Achievementsbarchart>{
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
    return Center(
        child:
            Consumer<StepsProvider>(
              builder: (context, stepsProvider, _) {
                return FutureBuilder<dynamic>(
                  future: stepsProvider.getStepsEachDay(),
                  builder: (context, snapshot) {
                    int step_goal = Provider.of<SettingsProvider>(context).goal;
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const CircularProgressIndicator();
                    }
                    if(!snapshot.hasData || snapshot.data==0){
                      return const Text("step data not available.");
                    }
                    final List<double> y_steps = getSteps(snapshot.data!); 
                    final List<String> x_days = getDate();

                    int weeks = snapshot.data!.length ~/ 7;

                    double deficit = getDeficit(snapshot.data!, step_goal); 

                    return Column(children:[
                        Container(height: 300, width : 350, padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),child:
                          SimpleBarChart(xAxisList: x_days, yAxisList: y_steps, xAxisName:"", yAxisName: '# of steps', interval: 2500),
                        ),
                        Container(width:300, child:Showdeficit()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Column(children: [
                            Text("${weeks}", style: TextStyle(fontSize: 80)), // this 20 needs to be a streak amount
                            Text("weeks of walking", style: TextStyle(fontSize: 20)),
                          ],),
                          Icon(Icons.local_fire_department, color: Theme.of(context).textTheme.labelMedium?.color, size: 150.0,),
                        ],),
                      ]          
                    );
                  },
                );
              },
            ),
        );
  }
}