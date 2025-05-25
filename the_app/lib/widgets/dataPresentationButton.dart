import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_app/provider/stepsProvider.dart';

// Button to load data for the èresentation
class PresentationButton extends StatelessWidget {
  const PresentationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        await Provider.of<StepsProvider>(
          context,
          listen: false,
        ).fillDataPresentation();
      },
      icon: Icon(Icons.bar_chart),
      label: Text('Load 2 Months of Data'),
    );
  }
}
