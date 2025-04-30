import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestExpiracyDateButton extends StatelessWidget {
  const TestExpiracyDateButton({super.key});

  Future<void> _simulateOldLogin(BuildContext context) async {
    final sp = await SharedPreferences.getInstance();
    final DateTime fakePastDate = DateTime.now().subtract(
      const Duration(days: 31),
    );
    await sp.setString('last_login', fakePastDate.toIso8601String());

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Simulated login 31 days ago')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _simulateOldLogin(context),
      icon: const Icon(Icons.access_time),
      label: const Text('Time Flies'),
    );
  }
}
