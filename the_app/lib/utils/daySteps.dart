class DaySteps {
  final DateTime day;
  //final int value;
  int value; //TODO: changed by Arthur

  DaySteps({required this.day, required this.value});

  /*
  DaySteps.fromJson(String date, Map<String, dynamic> json)
    : day = DateFormat('yyyy-MM-dd').parse('$date ${json["time"]}'),
      value = int.parse(json["value"]);
  */
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
