import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.home),
      label: const Text('Homepage'),
      onPressed: () => Navigator.pop(context),
    );
  }
}
