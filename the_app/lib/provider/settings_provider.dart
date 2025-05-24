import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier{
  String _name = 'Jane Doe'; //link username to this String for initial value
  String get name => _name;

  String? _sex;
  String? get sex => _sex;

  String _language = 'English';
  String get language => _language;

  bool _darkMode = false;
  bool get darkMode => _darkMode;

  bool _pushNotifications = true;
  bool get pushNotifications => _pushNotifications;

  DateTime? _birthday;
  DateTime? get birthday => _birthday;
  int? _age;
  int? get age => _age;

  int? _height; //default avg male [cm]
  int? get heigth => _height;

  double? _weight; //default avg male [kg]
  double? get weight => _weight;

  //Schrittlänge (cm) ≈ Körpergröße (cm) × 0.415
  int? _stepLength; //default avg male = 73 [cm] 
  int? get stepLength => _stepLength;

  // restingHeartRate_basic = 210 - age
  int? _restingHeartRate;
  int? get restingHeartRate => _restingHeartRate;

  void setName(String newName){
    _name = newName;
    notifyListeners();
  }

  void setDarkMode(bool value){
    _darkMode = value;
    notifyListeners();
  }

  void setLanguage(String newLanguage){
    _language = newLanguage;
    notifyListeners();
  }

  void setPushNotifications(bool newValue){
    _pushNotifications = newValue;
    notifyListeners();
  }

  void setSex(String? newSex){
    _sex = newSex;
    notifyListeners();
  }

  void setBirthday(DateTime? newBirthday){
    DateTime today = DateTime.now();
    int? newAge;

    if(newBirthday != null){
      newAge = today.year - newBirthday.year;
      if(newBirthday.month > today.month || 
        (newBirthday.month == today.month && newBirthday.day > today.day)){
          newAge--;
      }
      _restingHeartRate = 210 - newAge; //approximation --> put should be personisable as well
    }

    _birthday = newBirthday;
    _age = newAge;
    notifyListeners();
  }

  void setHeight(int? height){
    _height = heigth;
    if(height != null){
      _stepLength = (0.415 * (heigth ?? 0)).toInt();
    }
    notifyListeners();
  }

  void setWeight(double? weight){
    _weight = weight;
    notifyListeners();
  }

}