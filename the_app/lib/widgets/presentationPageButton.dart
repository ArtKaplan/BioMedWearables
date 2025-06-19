import 'package:flutter/material.dart';
import 'package:the_app/screens/presentationPage.dart';




class PresentationPageButton extends StatelessWidget {
  const PresentationPageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.align_vertical_bottom),
      label: const Text('Presentation Page'),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PresentationPage()),
        );
      },

    );
  }
}
