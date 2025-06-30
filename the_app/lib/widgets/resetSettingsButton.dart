import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_app/provider/settings_provider.dart';
import 'package:the_app/screens/settingsPage.dart';

// button to change loggin status and go back to login page

class ResetSettingsButton extends StatelessWidget {
  const ResetSettingsButton({super.key});

  //change logout status and go to login page
  Future<void> _resetSettings(BuildContext context) async {
    final settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
    await settingsProvider.deleteSettings();
    await settingsProvider.loadSettings();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SettingsPage()), //not sure if necessary
      (route) => false, // remove all previous routes
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.delete),
      label: const Text('Reset settings'),
      onPressed: () => _resetSettings(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
    );
  }
}
