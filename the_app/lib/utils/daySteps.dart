import 'package:intl/intl.dart';

class DaySteps {
  final DateTime day;
  final int value;

  DaySteps({required this.day, required this.value});

  DaySteps.fromJson(String date, Map<String, dynamic> json)
    : day = DateFormat('yyyy-MM-dd').parse('$date ${json["time"]}'),
      value = int.parse(json["value"]);

  @override
  String toString() {
    return 'Steps(day: $day, value: $value)';
  }
}
