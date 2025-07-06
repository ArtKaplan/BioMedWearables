import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_app/provider/stepsProvider.dart';
import 'package:the_app/provider/settings_provider.dart';

GetDeficit(steps,goal){
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

class Showdeficit extends StatefulWidget {
  const Showdeficit({super.key});

  @override
  State<Showdeficit> createState() => _Showdeficit();
}

class _Showdeficit extends State<Showdeficit>{
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

                    double deficit = GetDeficit(snapshot.data!, step_goal); 

                    return Column(children:[
                      if(deficit <= 0)                     
                        Text('Congrats! You are on track to reach your goal this week!'),
                      if(deficit>0)
                        Text('You need ${deficit.toInt()} more steps to reach your goal this week!'),
                      ]          
                    );
                  },
                );
              },
            ),
        );
  }
}