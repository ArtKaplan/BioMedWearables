import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

Future<int?> showNumberPickerDialog({
  required BuildContext context,
  required int initialValue,
  required int minValue,
  required int maxValue,
  required String unit,
}) async {
  return await showModalBottomSheet<int>(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      int currentValue = initialValue;
      
      return StatefulBuilder(
        builder: (context, setState) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NumberPicker(
                        minValue: minValue,
                        maxValue: maxValue,
                        value: currentValue,
                        onChanged: (value) => setState(() => currentValue = value),
                      ),
                      Text(unit),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context, currentValue),
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}