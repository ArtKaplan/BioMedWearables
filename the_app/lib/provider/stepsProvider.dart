import 'package:flutter/material.dart';
import 'package:the_app/utils/steps.dart';
import 'package:the_app/utils/daySteps.dart';
import 'package:the_app/utils/impact.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepsProvider extends ChangeNotifier {
  List<Steps> _presentation_todaySteps = [];
  List<DaySteps> _presentation_stepsEachDay = [];

  List<Steps> _todaySteps = [];
  //List<Steps> get todaySteps => _todaySteps;

  List<DaySteps> _stepsEachdays = [];
  //List<DaySteps> get stepsEachDay => _stepsEachdays;

  //int get todayTotalSteps => _todaySteps.fold(0, (sum, s) => sum + s.value);

  getTodaySteps() async {
    final sp = await SharedPreferences.getInstance();
    if (sp.getBool("presentation_mode") ?? false) {
      return _presentation_todaySteps;
    } else {
      return _todaySteps;
    }
  }

  getStepsEachDay() async {
    final sp = await SharedPreferences.getInstance();
    if (sp.getBool("presentation_mode") ?? false) {
      return _presentation_todaySteps;
    } else {
      return _presentation_stepsEachDay;
    }
  }
/*
  // return the total amout of steps done today
  Future<int> getTodayTotalSteps() async {
    final sp = await SharedPreferences.getInstance();
    if (sp.getBool("presentation_mode") ?? false) {
      return _presentation_todaySteps.fold(0, (sum, s) => sum + s.value);
    } else {
      updateTodaySteps();
      return _todaySteps.fold(
        0,
        (sum, s) => sum + s.value,
      ); // start at 0 accumulate in sum for each s in _todaySteps using the function after =>
    }
  }*/


  int? _cachedTodayTotal;

  Future<int> getTodayTotalSteps() async {
    final sp = await SharedPreferences.getInstance();
    if (sp.getBool("presentation_mode") ?? false) {
      _cachedTodayTotal = _presentation_todaySteps.fold(
        0,
        (sum, s) => sum! + s.value,
      );
    } else {
      if (_todaySteps.isEmpty) {
        await updateTodaySteps(); // this sets _todaySteps
      }
      _cachedTodayTotal = _todaySteps.fold(0, (sum, s) => sum! + s.value);
    }
    return _cachedTodayTotal!;
  }



  // add steps done at a specific time during the day for today
  Future<void> presentationAddStepsToday({
    required DateTime time,
    required int steps,
  }) async {
    final step = Steps(time: time, value: steps);
    _presentation_todaySteps.add(step);
    notifyListeners();
  }

  // add a number of steps done in a day to the presentation data
  void presentationAddStepsDay({required DateTime day, required int value}) {
    final dayStep = DaySteps(day: day, value: value);
    _presentation_stepsEachDay.add(dayStep);
    notifyListeners();
  }

  // reset the presentation data
  void cleanPresentationData() {
    _presentation_todaySteps = [];
    _presentation_stepsEachDay = [];
    notifyListeners();
  }

  //update the number of steps done today (= yesterday because data for today not available on the server)
  Future<void> updateTodaySteps() async {
    final DateTime today = DateTime.now();
    final DateTime yesterday = today.subtract(Duration(days: 1));
    final String dayStr = DateFormat('yyyy-MM-dd').format(yesterday);

    final steps = await Impact.stepsDuringDay(dayStr);
    _todaySteps = steps ?? [];

    _cachedTodayTotal = null; // Clear the cache
    print("updateTodaySteps called, got ${_todaySteps.length} items");
    notifyListeners();
  }


  // load the previous two month of data from the server
  Future<void> load2MonthData() async {
    _stepsEachdays = [];

    final DateTime today = DateTime.now();
    final DateTime yesterday = today.subtract(
      Duration(days: 1),
    ); // use yesterday because data only available the day after
    final DateTime startDate = DateTime(
      yesterday.year,
      yesterday.month - 2,
      yesterday.day,
    );
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

  // adds a number of days with the choosen number of steps in presentation data
  Future<void> addStepsAndDaysPresentationDate({
    required int stepsPerDay,
    required int numberOfDays,
  }) async {
    final sp = await SharedPreferences.getInstance();

    // Get the current fake date
    final dateString =
        sp.getString('presentation_date') ??
        DateFormat('yyyy-MM-dd').format(DateTime.now());
    DateTime fakeDate = DateFormat('yyyy-MM-dd').parse(dateString);

    final now = DateTime.now(); // to keep real time

    for (int i = 0; i < numberOfDays; i++) {
      final fakeDay = DateTime(
        fakeDate.year,
        fakeDate.month,
        fakeDate.day + i,
        now.hour,
        now.minute,
        now.second,
      );

      presentationAddStepsDay(day: fakeDay, value: stepsPerDay);
    }

    // Update presentation_date
    final newFakeDate = fakeDate.add(Duration(days: numberOfDays));
    final newDateString = DateFormat('yyyy-MM-dd').format(newFakeDate);
    await sp.setString('presentation_date', newDateString);
  }
}
