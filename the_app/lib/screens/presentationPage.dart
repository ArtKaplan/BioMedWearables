import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_app/widgets/homeButton.dart';
import 'package:the_app/widgets/presentationButtons.dart';
import 'package:provider/provider.dart';
import 'package:the_app/provider/StepsProvider.dart';

class PresentationPage extends StatelessWidget {
  const PresentationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder:
            (context) => Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    HomeButton(),
                    TwoMonthDataButton(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(child: Text('Presentation Mode')),
                        SwitchPresentation(),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Text('add 1000 steps today')),
                        Add1kStepsTodayButton(),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Text('add week of 5k steps')),
                        Add1Week5kSteps(),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: Text('add week of 12k steps')),
                        Add1Week12kSteps(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
} //presentation page


