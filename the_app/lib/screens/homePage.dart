import 'package:flutter/material.dart';
import 'package:the_app/provider/stepsProvider.dart';
import 'package:the_app/utils/loginStatus.dart';
import 'package:the_app/screens/sessionExpiredPage.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:provider/provider.dart';
import 'package:the_app/provider/settings_provider.dart';
import 'package:the_app/widgets/bottomNavigBar.dart';
import 'package:the_app/widgets/presentationPageButton.dart';

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

    // Update steps when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StepsProvider>().updateTodaySteps();
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
              padding: const EdgeInsets.fromLTRB(30, 50, 30, 15),
              child: Image.asset('lib/pictures/logo.png'),
            ),
            const PresentationPageButton(), // TODO (used for creating presentationpage, it's a mistake if still here and can be removed)

            Container(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 50),
              child: Text(
                'Welcome, ${Provider.of<SettingsProvider>(context).name}! \n Today\'s goal:',
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall?.copyWith(fontSize: 30),
                textAlign: TextAlign.center,
              ),
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

                    return SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                          minimum: 0,
                          maximum: 10000, // this should become the provider of the step goal
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
                                '${stepsDouble.toStringAsFixed(0)} / 10000', // this should become the provider of the step goal
                                style: Theme.of(context).textTheme.headlineSmall
                                    ?.copyWith(fontSize: 30),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigBar(currentPage: CurrentPage.home),
    );
  }

/*
  Widget _buildHomeScreen(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(30, 50, 30, 15),
              child: Image.asset('lib/pictures/logo.png'),
            ),
            const PresentationPageButton(), // TODO (used for creating presentationpage, it's a mistake if still here and can be removed)
            Container(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 50),
              child: Text(
                'Welcome, ${Provider.of<SettingsProvider>(context).name}! \n Today\'s goal:',
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall?.copyWith(fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
            FutureBuilder<int>(
              future: context.watch<StepsProvider>().getTodayTotalSteps(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                final double stepsDouble = snapshot.data!.toDouble(); // amount of steps done today

                return SfRadialGauge(
                  axes: <RadialAxis>[
                    RadialAxis(
                      minimum: 0,
                      maximum: 10000, // this should become the provider of the step goal
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
                            '${stepsDouble.toStringAsFixed(0)} / 10000', // this should become the provider of the step goal
                            style: Theme.of(
                              context,
                            ).textTheme.headlineSmall?.copyWith(fontSize: 30),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigBar(currentPage: CurrentPage.home),
    );
  }*/

  /*
  Widget _buildHomeScreen(BuildContext context) {
    int steps = await context.read<StepsProvider>().getTodayTotalSteps();
    double stepsDouble = steps.toDouble();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(30, 50, 30, 15),
              child: Image.asset('lib/pictures/logo.png'),
            ),
            PresentationPageButton(),// TODO (used for creating presentationpage, it's a mistake if still here and can be removed)
            Container(
              padding: EdgeInsets.fromLTRB(30, 30, 30, 50),
              child: Text(
                'Welcome, ${Provider.of<SettingsProvider>(context).name}! \n Today\'s goal:',
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall?.copyWith(fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
            SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  minimum: 0,
                  maximum:
                      10000, // this should become the provider of the step goal
                  showLabels: false,
                  showTicks: false,
                  axisLineStyle: AxisLineStyle(
                    thickness: 0.2,
                    cornerStyle: CornerStyle.bothCurve,
                    color: Color(0xFFDE7C5A),
                    thicknessUnit: GaugeSizeUnit.factor,
                  ),
                  pointers: <GaugePointer>[
                    RangePointer(
                      value:
                          context
                              .watch<StepsProvider>()
                              .getTodayTotalSteps()
                              .toDouble(), // amount of steps done today
                      cornerStyle: CornerStyle.bothCurve,
                      width: 0.2,
                      sizeUnit: GaugeSizeUnit.factor,
                      color:
                          Theme.of(context)
                              .appBarTheme
                              .titleTextStyle
                              ?.color, //Color(0xFF66101F),
                    ),
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      positionFactor: 0,
                      angle: 90,
                      widget: Text(
                        stepsDouble.toString() +
                            ' / 10000', // this should become amount stepped today / goal //to get today's steps : context.watch<StepsProvider>().todayTotalSteps.toDouble()
                        style: Theme.of(
                          context,
                        ).textTheme.headlineSmall?.copyWith(fontSize: 30),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          Card(
            elevation: 8.0,
            margin: const EdgeInsets.all(50.0),
            child: Container(
              decoration: BoxDecoration(color: Theme.of(context).textTheme.labelMedium?.color),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                title: Text('Get hiking!', style: const TextStyle(color: Colors.white, fontSize:50),textAlign: TextAlign.center,),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => Recommendhikepage()),
                    );
                },
              ),
            ),
          ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigBar(currentPage: CurrentPage.home),
    );
  }*/
}
