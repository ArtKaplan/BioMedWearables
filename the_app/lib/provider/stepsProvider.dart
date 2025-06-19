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
    final String dayStr = DateFormat('yyyy-MM-dd').format(today);

    final steps = await Impact.stepsDuringDay(dayStr);
    _todaySteps = steps ?? [];

    print("updateTodaySteps called, got ${_todaySteps.length} items");//TODO
    notifyListeners();
  }

  Future<void> fillDataPresentation() async {
    _stepsEachdays = [];

    final DateTime today = DateTime.now();
    final DateTime startDate = DateTime(today.year, today.month - 2, today.day);
    final formatter = DateFormat('yyyy-MM-dd');

    for (int i = 0; i <= today.difference(startDate).inDays; i++) {
      final currentDate = startDate.add(Duration(days: i));
      final String dayStr = formatter.format(currentDate);

      final stepsList = await Impact.stepsDuringDay(dayStr);
      if (stepsList != null && stepsList.isNotEmpty) {
        final int total = stepsList.fold(0, (sum, s) => sum + s.value);
        _stepsEachdays.add(DaySteps(day: currentDate, value: total));
      }
    }
    /*
    //ARTHUR
    List<DaySteps> _allSteps = [];
    List<DaySteps> get allSteps => _allSteps;

    void updateSteps(List<DaySteps> newSteps) {
      _allSteps = newSteps;
      notifyListeners();
    }

    int getStepsForDay(DateTime targetDay) {
      final matchingDay = _allSteps.firstWhere(
        (steps) => _isSameDay(steps.day, targetDay),
        orElse: () => DaySteps(day: targetDay, value: 0),
      );
      return matchingDay.value;
    }
*/
    notifyListeners();
  }
}
