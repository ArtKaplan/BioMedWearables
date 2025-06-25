import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_app/utils/loginStatus.dart';

class SettingsProvider extends ChangeNotifier {
  late SharedPreferences _prefs;
  SettingsProvider(this._prefs);

  late String? _username;
  String? get username => _username;

  /// Init and get provider variables
  String _name = 'Jane Doe';
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

  int? _height;
  int? get height => _height;

  double? _weight;
  double? get weight => _weight;

  bool _stepLength_personalized = false;
  bool get stepLength_personalized => _stepLength_personalized;

  int? _stepLength;
  int? get stepLength => _stepLength;

  bool _maxHeartRate_personalized = false;
  bool get maxHeartRate_personalized => _maxHeartRate_personalized;

  int? _maxHeartRate;
  int? get maxHeartRate => _maxHeartRate;

  // error values because sharedPref cannot handle null
  static const String stringError = 'ERROR';
  static const int intError = -1;
  static const double doubleError = -1.0;
  static const String dateError = '0000-00-00';

 
  Future<void> init() async{
    _prefs = await SharedPreferences.getInstance();
    _username = _prefs.getString('username');
    print('INIT: username = $_username');
    await _loadSettings();
    print('INIT: username = $_username');
    notifyListeners();
  }

  
  Future<void> _loadSettings() async {
    _name = _prefs.getString(_key('name')) ?? 'Jane Doe';
    _darkMode = _prefs.getBool(_key('darkMode')) ?? false;
    _pushNotifications = _prefs.getBool(_key('pushNotifications')) ?? true;
    _language = _prefs.getString(_key('language')) ?? 'English';

    final sexStr = _prefs.getString(_key('sex')) ?? stringError;
    _sex = sexStr == stringError ? null : sexStr;

    final birthdayStr = _prefs.getString(_key('birthday')) ?? dateError;
    _birthday = birthdayStr == dateError ? null : await _getBirthday(birthdayStr);

    final ageInt = _prefs.getInt(_key('age')) ?? intError;
    _age = ageInt == intError ? null : ageInt;

    final heightInt = _prefs.getInt(_key('height')) ?? intError;
    _height = heightInt == intError ? null : heightInt;

    final weightDouble = _prefs.getDouble(_key('weight')) ?? doubleError;
    _weight = weightDouble == doubleError ? null : weightDouble;

    _stepLength_personalized = _prefs.getBool(_key('stepLength_personalized')) ?? false;

    final stepLengthInt = _prefs.getInt(_key('stepLength')) ?? intError;
    _stepLength = stepLengthInt == intError ? null : stepLengthInt;

    _maxHeartRate_personalized = _prefs.getBool(_key('maxHeartRate_personalized')) ?? false;

    final maxHRInt = _prefs.getInt(_key('maxHeartRate')) ?? intError;
    _maxHeartRate = maxHRInt == intError ? null : maxHRInt;
    
    print('key = ${_key('name')} : value = $_name');
    notifyListeners();
  }

  String _key(String baseKey) {
    if (username != null && username!.isNotEmpty){
      //print('Key = ${_prefs.getString('username')!}_$baseKey');
      return '${username}_$baseKey';
    } else{
      print('Key = $baseKey');
      return baseKey;
    }
  }

  Future<void> _save<T>(String key, T? value) async {
    print('BEFORE: Key = ${_key(key)} : value = ${_prefs.get(key)}');
    // if null set ERROR value because sharedPref cannot handle null
    if (value == null) {
      if (T == String) {
        await _prefs.setString(key, stringError);
      } else if (T == int) {
        await _prefs.setInt(key, intError);
      } else if (T == bool) {
        await _prefs.setBool(key, false);
      } else if (T == double) {
        await _prefs.setDouble(key, doubleError);
      } else {
        throw Exception('Unsupported type for null value saving');
      }
      return;
    }

    if (value is String) {
      await _prefs.setString(key, value);
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is bool) {
      await _prefs.setBool(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    } else {
      throw Exception('Unsupported type for SharedPreferences');
    }

    print('AFTER: Key = ${_key(key)} : value = ${_prefs.get(key)}');
  } 
  
  Future<void> _saveDateTime(String key, DateTime? newBirthday) async {
    //birthday has to be converted to string to be save in sharedPreference!
    final birthdayString = "${newBirthday?.year}-${newBirthday?.month}-${newBirthday?.day}";
    if(username != null && username!.isNotEmpty){ 
      if (newBirthday == null) {
        await _prefs.setString(key, dateError);
      } else {
        await _prefs.setString(key, birthdayString);
      }
    }
  }

  Future<DateTime?> _getBirthday(String? birthdayString) async{
    print('birthdayString = $birthdayString');
    if (birthdayString == null) return null;

    final parts = birthdayString.split('-'); 
    if (parts.length != 3) return null;

    final year = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final day = int.tryParse(parts[2]);

    if (year == null || month == null || day == null) return null;
    print('birthday as DateTime = ${DateTime(year, month, day)}');
    return DateTime(year, month, day);
  }

  Future<void> setName(String newName) async {
    _name = newName;
    //await _prefs.setString(_key('name'), _name);
    await _save('name', newName);
    notifyListeners();
  }

  Future<void> setDarkMode(bool value) async {
    _darkMode = value;
    //await _prefs.setBool('darkMode', value);
    await _save('darkMode', value);
    notifyListeners();
  }

  Future<void> setLanguage(String newLanguage) async {
    _language = newLanguage;
    //await _prefs.setString('language', newLanguage);
    await _save('language', newLanguage);
    notifyListeners();
  }

  Future<void> setPushNotifications(bool newValue) async {
    _pushNotifications = newValue;
    //await _prefs.setBool('pushNotifications', newValue);
    await _save('pushNotifications', _pushNotifications);
    notifyListeners();
  }

  Future<void> setSex(String? newSex) async {
    _sex = newSex;
    //await _prefs.setString('sex', _sex!);
    await _save('sex', _sex);
    notifyListeners();
  }

  Future<void> setBirthday(DateTime? newBirthday) async {
    DateTime today = DateTime.now();
    int? newAge;

    if (newBirthday != null) {
      newAge = today.year - newBirthday.year;
      if (newBirthday.month > today.month ||
          (newBirthday.month == today.month && newBirthday.day > today.day)) {
        newAge--;
      }
      if (!maxHeartRate_personalized) {
        await setMaxHeartRate(null);
      }
    }

    _birthday = newBirthday;
    await _saveDateTime(_key('birthday'), _birthday);
    
    print('age = $newAge');
    _age = newAge;
    await _save<int>('age', newAge);
    notifyListeners();
  }

  Future<void> setHeight(int? newHeight) async {
    _height = newHeight;
    //await _prefs.setInt(_key('height'), _height!);
    await _save<int>('height', newHeight);
    await setStepLength(null); // Schrittweite nach Höhe zurücksetzen
    notifyListeners();
  }

  Future<void> setWeight(double? newWeight) async {
    _weight = newWeight;
    //await _prefs.setDouble(_key('weight'), _weight!); TODO
    await _save('weight', _weight);
    notifyListeners();
  }

  Future<void> setMaxHeartRate_personalized(bool newValue) async {
    _maxHeartRate_personalized = newValue;
    await _save('maxHeartRate_personalized', newValue);
    await setMaxHeartRate(null);
    notifyListeners();
  }

  Future<void> setMaxHeartRate(int? newValue) async {
    if (_maxHeartRate_personalized) {
      _maxHeartRate = newValue;
      await _save<int>('maxHeartRate', newValue);
    } else if (!_maxHeartRate_personalized && age != null) {
      _maxHeartRate = (208 - (0.7 * age!)).round();
      await _save<int>('maxHeartRate', _maxHeartRate);
    } else {
      _maxHeartRate = null;
      await _save<int>('maxHeartRate', null);
    }
    notifyListeners();
  }

  Future<void> setStepLength_personalized(bool newValue) async {
    _stepLength_personalized = newValue;
    await _save('stepLength_personalized', newValue);
    await setStepLength(null);
    notifyListeners();
  }

  Future<void> setStepLength(int? newValue) async {
    if (stepLength_personalized) {
      _stepLength = newValue;
      await _save<int>('stepLength', newValue);
    } else if (!stepLength_personalized && height != null) {
      _stepLength = (0.415 * (height ?? 0)).toInt();
      await _save<int>('stepLength', _stepLength);
    } else {
      _stepLength = null;
      await _save<int>('stepLength', null);
    }
    notifyListeners();
  }
}
