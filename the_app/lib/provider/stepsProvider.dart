import 'package:flutter/material.dart';
import 'package:the_app/utils/steps.dart';
import 'package:the_app/utils/daySteps.dart';
import 'package:the_app/utils/impact.dart';
import 'package:intl/intl.dart';

class StepsProvider extends ChangeNotifier {
  List<Steps>? _todaySteps = [];
  List<Steps>? get todaySteps => _todaySteps;

  List<DaySteps> _stepsEachdays = [];
  List<DaySteps> get stepsEachDay => _stepsEachdays;

  Future<void> updateTodaySteps() async {
    final DateTime today = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String dayStr = formatter.format(today);

    final steps = await Impact.stepsDuringDay(dayStr);
    if (steps != null) {
      _todaySteps = steps;
    }

    notifyListeners();
  }

  // get data for the presentation
  Future<void> fillDataPresentation() async {
    _stepsEachdays.clear(); // Clear any previous data

    final DateTime today = DateTime.now();
    final DateTime startDate = DateTime(today.year, today.month - 2, today.day);
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    for (int i = 0; i <= today.difference(startDate).inDays; i++) {
      final DateTime currentDate = startDate.add(Duration(days: i));
      final String dayStr = formatter.format(currentDate);

      final List<Steps>? stepsList = await Impact.stepsDuringDay(dayStr);
      if (stepsList != null && stepsList.isNotEmpty) {
        final int total = stepsList.fold(0, (sum, s) => sum + s.value);
        _stepsEachdays.add(DaySteps(day: currentDate, value: total));
      }
    }

    notifyListeners();
  }
}
