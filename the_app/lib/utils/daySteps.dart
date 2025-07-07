class DaySteps {
  final DateTime day;
  int value;

  DaySteps({required this.day, required this.value});

  // to save Steps userspecific
  factory DaySteps.fromMap(Map<String, dynamic> json) {
    return DaySteps(
      day: DateTime.parse(json['day']),
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() => {
    'day': day.toIso8601String(),
    'value': value,
  };

  @override
  String toString() {
    return 'Steps(day: $day, value: $value)';
  }
}
