import 'package:flutter/material.dart';
import 'package:the_app/provider/award_provider.dart';
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
    //steps.init();
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
                          //maximum: 10000, // this should become the provider of the step goal
                          maximum: Provider.of<StepsProvider>(context).step_weeklyGoal.toDouble(),
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
                                '${stepsDouble.toStringAsFixed(0)} / ${Provider.of<StepsProvider>(context).step_weeklyGoal.toString()}', // this should become the provider of the step goal
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
}