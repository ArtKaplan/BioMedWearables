import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_app/provider/stepsProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Button to load data for the presentation
class TwoMonthDataButton extends StatelessWidget {
  const TwoMonthDataButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        await Provider.of<StepsProvider>(
          context,
          listen: false,
        ).load2MonthData();
      },
      icon: Icon(Icons.bar_chart),
      label: Text('Load 2 Months of Data'),
    );
  }
}

// The switch button
class SwitchPresentation extends StatefulWidget {
  final VoidCallback? onChanged;

  const SwitchPresentation({super.key, this.onChanged});

  @override
  State<SwitchPresentation> createState() => _SwitchPresentationState();
}

class _SwitchPresentationState extends State<SwitchPresentation> {
  bool light = false;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((sp) {
      final currentState = sp.getBool('presentation_mode') ?? false;
      setState(() {
        light = currentState;
      });
      widget.onChanged?.call();// notify parents to refresh UI
    });
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      // This bool value toggles the switch.
      value: light,
      activeColor: Colors.green, //TODO theme color
      onChanged: (bool value) async {
        // This is called when the user toggles the switch.
        final sp = await SharedPreferences.getInstance();

        bool? previousState =
            sp.getBool('presentation_mode') ??
            false; // if not set yet(getBool return null -> sets it to flase)

        // going to presentation mode : reset fake date and reset presentation data
        if (sp.getBool('presentation_mode') ?? false) {
          //final stepsProvider = Provider.of<StepsProvider>(context, listen: false);
          //stepsProvider.cleanPresentationData();
          context.read<StepsProvider>().cleanPresentationData();
          sp.setString('presentation_date', "2027-07-08");
        }

        await sp.setBool('presentation_mode', !previousState);
        setState(() {
          light = value;
          print(sp.getBool('presentation_mode'));
        });
        widget.onChanged?.call();
      },
    );
  }
}

class Add1kStepsTodayButton extends StatelessWidget {
  const Add1kStepsTodayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.directions_walk),
      label: const Text('Add 1k Steps'),
      onPressed: () {
        final now = DateTime.now();

        context.read<StepsProvider>().presentationAddStepsToday(
          time: now,
          steps: 1000,
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(content: Text('Added 1K Steps to Today.')),
          );
      },
    );
  }
}

class Add1Week5kSteps extends StatelessWidget {
  const Add1Week5kSteps({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(Icons.directions_walk),
      label: Text('Add 1 Week 5k Steps'),
      onPressed: () {
        context.read<StepsProvider>().addStepsAndDaysPresentationDate(
          stepsPerDay: 5000,
          numberOfDays: 7,
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(content: Text('Added a Week of 5000 Steps.')),
          );

      },
    );
  }
}

class Add1Week12kSteps extends StatelessWidget {
  const Add1Week12kSteps({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        context.read<StepsProvider>().addStepsAndDaysPresentationDate(
          stepsPerDay: 12000,
          numberOfDays: 7,
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(content: Text('Added a Week of 12000 Steps.')),
          );
        

      },
      icon: const Icon(Icons.directions_walk),
      label: const Text('Add 12k Week'),
    );
  }
}


/*
// Button to load data for the presentation
class TwoMonthDataButton extends StatelessWidget {
  const TwoMonthDataButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        await Provider.of<StepsProvider>(
          context,
          listen: false,
        ).load2MonthData();
      },
      icon: Icon(Icons.bar_chart),
      label: Text('Load 2 Months of Data'),
    );
  }
}
*/