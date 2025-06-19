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
  int? get height => _height;

  double? _weight; //default avg male [kg]
  double? get weight => _weight;

  bool _stepLength_personalized = false;
  bool get stepLength_personalized => _stepLength_personalized;

  //Schrittlänge (cm) ≈ Körpergröße (cm) × 0.415
  int? _stepLength; 
  int? get stepLength => _stepLength;

  bool _maxHeartRate_personalized = false;
  bool get maxHeartRate_personalized => _maxHeartRate_personalized;

  // maxHeartRate_Taneka =  208 - (0.7 * age) //TANEKA-formula
  int? _maxHeartRate;
  int? get maxHeartRate => _maxHeartRate;

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
      if(!maxHeartRate_personalized){
      _maxHeartRate = (208 - (0.7 * newAge)).round(); //TANEKA-formula --> put should be personisable as well
      }
    }

    _birthday = newBirthday;
    _age = newAge;
    notifyListeners();
  }

  void setHeight(int? height){
    _height = height;
    setStepLength(null); //will get correct value assigned in setStepLength
    notifyListeners();
  }

  void setWeight(double? weight){
    _weight = weight;
    notifyListeners();
  }

  void setMaxHeartRate_personalized(bool newValue){
    _maxHeartRate_personalized = newValue;
    notifyListeners();
  }

  void setMaxHeartRate(int? newValue){
    _maxHeartRate = newValue;
    notifyListeners();
  }

  void setStepLength_personalized(bool newValue){
    _stepLength_personalized = newValue;
    setStepLength(null);
    notifyListeners();
  }

  void setStepLength(int? newValue){
    if(stepLength_personalized){
      _stepLength = newValue;
    } else if(!stepLength_personalized && height != null){
      _stepLength = (0.415 * (height ?? 0)).toInt();
    } else{_stepLength = null;}
    notifyListeners();
  }

}