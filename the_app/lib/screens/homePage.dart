import 'package:flutter/material.dart';
import 'package:the_app/provider/award_provider.dart';
import 'package:the_app/provider/stepsProvider.dart';
import 'package:the_app/screens/favouriteHikesPage.dart';
import 'package:the_app/utils/loginStatus.dart';
import 'package:the_app/screens/sessionExpiredPage.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:provider/provider.dart';
import 'package:the_app/provider/settings_provider.dart';
import 'package:the_app/widgets/bottomNavigBar.dart';
import 'package:the_app/widgets/presentationPageButton.dart';
import 'package:the_app/screens/allHikesPage.dart';

getDeficit1(steps,goal){
  double total = 0;
  int count = 0;

  for (int i = steps.length - 1; count < 7; i--, count++) {
    if (i >= 0) { // negative if not enough elements
      total += steps[i];
    } else {
      total += 0; 
    }
  }
  return goal * 7 - total;
}
getDeficit2(steps,goal){
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
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<LoginStatus>? _loginStatusFuture;

  @override
  void initState() {
    super.initState();
    _loginStatusFuture = checkLoginStatus();

    /*
    // Update steps when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StepsProvider>().updateTodaySteps();
      context.read<SettingsProvider>().init();
      context.read<AwardProvider>().init();
    });
    */
    Future.microtask(() {
    final steps = context.read<StepsProvider>();
    // final settings = context.read<SettingsProvider>();
    final award = context.read<AwardProvider>();

    steps.updateTodaySteps();
    // settings.init();
    award.init();
    steps.init();
  });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LoginStatus>(
      future: _loginStatusFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // catch an expired session
        if (snapshot.data == LoginStatus.expired) {
          logOutInfo();

          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const SessionExpiredPage()),
              (route) => false,
            );
          });
          return const SizedBox(); // empty placeholder
        }
        
        return _buildHomeScreen(context);
      },
    );
  }

  Widget _buildHomeScreen(BuildContext context) {
      return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(30, 25, 30, 0),
              child: Image.asset('lib/pictures/logo.png'),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(30, 25, 30, 15),
              child: Text(
                'Welcome, ${Provider.of<SettingsProvider>(context).name}!',
                style: TextStyle(color: Theme.of(context).textTheme.titleLarge?.color, fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),
            Consumer<StepsProvider>(
              builder: (context, stepsProvider, _) {
                int step_goal = Provider.of<SettingsProvider>(context).goal;
                return FutureBuilder<dynamic>(
                  future: stepsProvider.getStepsEachDay(),
                  builder: (context, snapshot) {
                    double deficit = 0;
                    if(!snapshot.hasData || snapshot.data==0){
                      deficit = getDeficit1([0,0,0,0,0,0,0], step_goal);
                    }
                    else{
                      final steps = snapshot.data!;
                      deficit = getDeficit2(steps, step_goal);
                    }

                    return Column(
                      children:[
                        if(deficit <= 0)
                          Card(
                            elevation: 8.0,
                            margin: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
                            child: Container(
                              decoration: BoxDecoration(color: Theme.of(context).textTheme.labelMedium?.color),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                title: Text('You\'re all set for this week! Feeling up for a hike? Click here to pick one.', style: const TextStyle(color: Colors.white),),
                                leading: Icon(IconData(0xe149, fontFamily: 'MaterialIcons'), color: Color(0xFF66101F), size: 50),
                                onTap: (){
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (_) => Allhikespage()),
                                  );
                                },
                              ),
                            ),
                          ),
                        if(deficit>0)
                          Card(
                            elevation: 8.0,
                            margin: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
                            child: Container(
                              decoration: BoxDecoration(color: Theme.of(context).textTheme.labelMedium?.color),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                title: Text('This week, you\'re still ${deficit.toInt()} steps short of reaching your goal. Click here to see which hike will help you reach it!', style: const TextStyle(color: Colors.white),),
                                leading: Icon(Icons.hiking, color: Color(0xFF66101F), size: 75),
                                onTap: (){
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (_) => FavouriteHikesPage()),
                                  );
                                },
                              ),
                            ),
                          ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(30, 30, 30,0),
                          child: Text(
                            'Today\'s steps:',
                            style: TextStyle(color: Theme.of(context).textTheme.titleLarge?.color, fontSize: 25),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ]
                    );
                  }
                );
              }
            ),
            Consumer<StepsProvider>(
              builder: (context, stepsProvider, _) {
                return FutureBuilder<int>(
                  future: stepsProvider.getTodayTotalSteps(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }

                    final double stepsDouble = snapshot.data!.toDouble(); // amount of steps done today
                    return
                        Container(width:300, child:
                          SfRadialGauge(
                            axes: <RadialAxis>[
                              RadialAxis(
                                minimum: 0,
                                maximum: Provider.of<SettingsProvider>(context).goal.toDouble(), 
                                showLabels: false,
                                showTicks: false,
                                axisLineStyle: AxisLineStyle(
                                  thickness: 0.2,
                                  cornerStyle: CornerStyle.bothCurve,
                                  color: const Color(0xFFDE7C5A),
                                  thicknessUnit: GaugeSizeUnit.factor,
                                ),
                                pointers: <GaugePointer>[
                                  RangePointer(
                                    value: stepsDouble,
                                    cornerStyle: CornerStyle.bothCurve,
                                    width: 0.2,
                                    sizeUnit: GaugeSizeUnit.factor,
                                    color:
                                        Theme.of(
                                          context,
                                        ).appBarTheme.titleTextStyle?.color,
                                  ),
                                ],
                                annotations: <GaugeAnnotation>[
                                  GaugeAnnotation(
                                    positionFactor: 0,
                                    angle: 90,
                                    widget: Text(
                                      '${stepsDouble.toStringAsFixed(0)} / ${Provider.of<SettingsProvider>(context).goal}', 
                                      style: Theme.of(context).textTheme.headlineSmall
                                          ?.copyWith(fontSize: 30),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        );
                  },
                );
              },
            ),
            const PresentationPageButton(), // TODO (used for creating presentationpage, it's a mistake if still here and can be removed)
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigBar(currentPage: CurrentPage.home),
    );
  }
}