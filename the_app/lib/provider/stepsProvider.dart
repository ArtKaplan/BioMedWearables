import 'package:flutter/material.dart';
import 'package:the_app/utils/steps.dart';
import 'package:the_app/utils/daySteps.dart';
import 'package:the_app/utils/impact.dart';
import 'package:intl/intl.dart';

class StepsProvider extends ChangeNotifier {
  int get todayTotalSteps => _todaySteps.fold(0, (sum, s) => sum + s.value);

  List<Steps> _todaySteps = [];
  List<Steps> get todaySteps => _todaySteps;

  List<DaySteps> _stepsEachdays = [];
  List<DaySteps> get stepsEachDay => _stepsEachdays;

  Future<void> updateTodaySteps() async {
    final DateTime today = DateTime.now();
    final DateTime yesterday = today.subtract(Duration(days: 1)); // use yesterday because data only available the day after
    final String dayStr = DateFormat('yyyy-MM-dd').format(yesterday);

    final steps = await Impact.stepsDuringDay(dayStr);
    _todaySteps = steps ?? [];

    print("updateTodaySteps called, got ${_todaySteps.length} items"); 
    notifyListeners();
  }

  Future<void> fillDataPresentation() async {
    _stepsEachdays = [];

    final DateTime today = DateTime.now();
    final DateTime yesterday = today.subtract(
      Duration(days: 1),
    ); // use yesterday because data only available the day after
    final DateTime startDate = DateTime(yesterday.year, yesterday.month - 2, yesterday.day);
    final formatter = DateFormat('yyyy-MM-dd');

    for (int i = 0; i <= yesterday.difference(startDate).inDays; i++) {
      final currentDate = startDate.add(Duration(days: i));
      final String dayStr = formatter.format(currentDate);

      final stepsList = await Impact.stepsDuringDay(dayStr);
      if (stepsList != null && stepsList.isNotEmpty) {
        final int total = stepsList.fold(0, (sum, s) => sum + s.value);
        _stepsEachdays.add(DaySteps(day: currentDate, value: total));
      } else {
        _stepsEachdays.add(DaySteps(day: currentDate, value: 0));
      }
    }

    notifyListeners();
  }
}
