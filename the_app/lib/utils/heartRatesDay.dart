import 'package:intl/intl.dart';

class HeartRatesDay {
  final DateTime time;
  final int value;
  final int confidence;

  HeartRatesDay({
    required this.time,
    required this.value,
    required this.confidence,
  });

  HeartRatesDay.fromJson(String date, Map<String, dynamic> json)
    : time = DateFormat('yyyy-MM-dd HH:mm:ss').parse('$date ${json["time"]}'),
      value = int.parse(json["value"]),
      confidence = int.parse(json["confidence"]);

  @override
  String toString() {
    return 'HeartRates(time: $time, value: $value, confidence: $confidence)';
  }

  factory HeartRatesDay.fromMap(Map<String, dynamic> json) {
    return HeartRatesDay(
      time: DateTime.parse(json['time']),
      value: json['value'],
      confidence: json['confidence'],
    );
  }

  Map<String, dynamic> toJson() => {
    'time': time.toIso8601String(),
    'value': value,
    'confidence': confidence,
  };
}
