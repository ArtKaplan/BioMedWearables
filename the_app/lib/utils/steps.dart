import 'package:intl/intl.dart';

class Steps {
  final DateTime time;
  final int value;

  Steps({required this.time, required this.value});

  Steps.fromJson(String date, Map<String, dynamic> json)
    : time = DateFormat('yyyy-MM-dd HH:mm:ss').parse('$date ${json["time"]}'),
      value = int.parse(json["value"]);

  @override
  String toString() {
    return 'Steps(time: $time, value: $value)';
  }

  factory Steps.fromMap(Map<String, dynamic> json) {
    return Steps(
      time: DateTime.parse(json['time']),
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() => {
    'time': time.toIso8601String(),
    'value': value,
  };
}
