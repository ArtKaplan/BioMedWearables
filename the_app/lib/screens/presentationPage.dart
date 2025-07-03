import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_app/widgets/homeButton.dart';
import 'package:the_app/widgets/presentationButtons.dart';

class PresentationPage extends StatefulWidget {
  const PresentationPage({super.key});

  @override
  State<PresentationPage> createState() => _PresentationPageState();
}

class _PresentationPageState extends State<PresentationPage> {
  bool showPresentationButtons = false;

  @override
  void initState() {
    super.initState();
    _loadPreference();
  }

  Future<void> _loadPreference() async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      showPresentationButtons = sp.getBool("presentation_mode") ?? false;
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder:
            (context) => Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(30, 50, 30, 15),
                        child: Image.asset('lib/pictures/logo.png'),
                      ),
                      HomeButton(),
                      TwoMonthDataButton(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Expanded(child: Text('Presentation Mode')),
                          SwitchPresentation(onChanged: _loadPreference,),
                        ],
                      ),
                      if (showPresentationButtons) ...[ // spread operator to insert elements of the list into another
                        const SizedBox(height: 16),
                        Row(
                          children: const [
                            Expanded(child: Text('add 1000 steps today')),
                            Add1kStepsTodayButton(),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: const [
                            Expanded(child: Text('add week of 5k steps')),
                            Add1Week5kSteps(),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: const [
                            Expanded(child: Text('add week of 12k steps')),
                            Add1Week12kSteps(),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
  }

}
