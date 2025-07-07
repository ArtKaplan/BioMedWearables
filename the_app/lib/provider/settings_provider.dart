import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  //late SharedPreferences _prefs;
  final SharedPreferences _prefs;
  SettingsProvider(this._prefs);
  //String get username => _prefs.getString('username') ?? 'default';

  String? _username;
  String? get username => _username;

  /// Init and get provider variables
  String _name = 'Jane Doe';
  String get name => _name;

  int _goal = 10000;
  int get goal => _goal;

  String? _sex;
  String? get sex => _sex;

  int? _font;
  int? get font => _font;

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

  bool _stepLengthPersonalized = false;
  bool get stepLengthPersonalized => _stepLengthPersonalized;

  int? _stepLength = 72;
  int? get stepLength => _stepLength;

  bool _maxHeartRatePersonalized = false;
  bool get maxHeartRatePersonalized => _maxHeartRatePersonalized;

  int? _maxHeartRate;
  int? get maxHeartRate => _maxHeartRate;

  // error values because sharedPref cannot handle null
  static const String stringError = 'ERROR';
  static const int intError = -1;
  static const double doubleError = -1.0;
  static const String dateError = '0000-00-00';

  Future<void> init({String? user}) async {
    _username = _prefs.getString('username') ?? 'default';
    notifyListeners();
    await loadSettings();
  }

  Future<void> loadSettings() async {
    if (username == null || username == 'default') {
      //load default settings
      _age = null;
      _birthday = null;
      _darkMode = false;
      _height = null;
      _language = 'English';
      _maxHeartRatePersonalized = false;
      _maxHeartRate = null;
      _name = 'Jane Doe';
      _goal = 10000;
      _pushNotifications = true;
      _sex = null;
      _font = 14;
      _stepLengthPersonalized = false;
      _stepLength = 72;
      _weight = null;
      notifyListeners();
    } else {
      _age = _prefs.getInt(_key('age')) ?? null;
      _darkMode = _prefs.getBool(_key('darkMode')) ?? false;
      _height = _prefs.getInt(_key('height'));
      _language = _prefs.getString(_key('language')) ?? 'English';
      _maxHeartRate = _prefs.getInt(_key('maxHeartRate'));
      _maxHeartRatePersonalized =
          _prefs.getBool(_key('maxHeartRate_personalized')) ?? false;
      _name = _prefs.getString(_key('name')) ?? 'Jane Doe';
      _goal = _prefs.getInt(_key('goal')) ?? 10000;
      _pushNotifications = _prefs.getBool(_key('pushNotifications')) ?? true;
      _sex = _prefs.getString(_key('sex'));
      _font = _prefs.getInt(_key('font'));
      _stepLength = _prefs.getInt(_key('stepLength')) ?? 72;
      _stepLengthPersonalized =
          _prefs.getBool(_key('stepLength_personalized')) ?? false;
      _weight = _prefs.getDouble(_key('weight'));

      final birthdayStr = _prefs.getString(_key('birthday'));
      _birthday = await _getBirthday(birthdayStr);

      notifyListeners();
    }
  }

  Future<DateTime?> _getBirthday(String? birthdayString) async {
    //print('birthdayString = $birthdayString');
    if (birthdayString == null) return null;

    final parts = birthdayString.split('-');
    if (parts.length != 3) return null;

    final year = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final day = int.tryParse(parts[2]);

    if (year == null || month == null || day == null) return null;
    return DateTime(year, month, day);
  }

  Future<void> deleteSettings() async {
    if (_prefs.getString('username') != null) {
      await _prefs.remove(_key('age'));
      await _prefs.remove(_key('birthday'));
      await _prefs.remove(_key('darkMode'));
      await _prefs.remove(_key('height'));
      await _prefs.remove(_key('language'));
      await _prefs.remove(_key('maxHeartRate'));
      await _prefs.remove(_key('maxHeartRate_personalized'));
      await _prefs.remove(_key('name'));
      await _prefs.remove(_key('goal'));
      await _prefs.remove(_key('pushNotifications'));
      await _prefs.remove(_key('sex'));
      await _prefs.remove(_key('font'));
      await _prefs.remove(_key('stepLength'));
      await _prefs.remove(_key('stepLength_personalized'));
      await _prefs.remove(_key('weight'));
      notifyListeners();
    } else {
      //print('no username detected');
    }
  }

  String _key(String baseKey) {
    if (username != null && username!.isNotEmpty) {
      return '${username}_$baseKey';
    } else {
      return baseKey;
    }
  }

  Future<void> setName(String newName) async {
    _name = newName;
    await _prefs.setString(_key('name'), newName);
    notifyListeners();
  }

  Future<void> setGoal(int newGoal) async {
    _goal = newGoal;
    await _prefs.setInt(_key('goal'), newGoal);
    notifyListeners();
  }

  Future<void> setDarkMode(bool value) async {
    _darkMode = value;
    notifyListeners();
  }

  /// for international edition in th future
  Future<void> setLanguage(String newLanguage) async {
    _language = newLanguage;
    notifyListeners();
  }

  Future<void> setPushNotifications(bool newValue) async {
    _pushNotifications = newValue;
    notifyListeners();
  }

  Future<void> setSex(String? newSex) async {
    _sex = newSex;
    await _prefs.setString('sex', _sex!);
    notifyListeners();
  }

  Future<void> setFont(int? newFont) async {
    _font = newFont;
    await _prefs.setInt('fpnt', _font!);
    notifyListeners();
  }

  Future<void> setBirthday(DateTime? newBirthday) async {
    DateTime today = DateTime.now();
    int newAge = 0;

    if (newBirthday != null) {
      newAge = today.year - newBirthday.year;
      if (newBirthday.month > today.month ||
          (newBirthday.month == today.month && newBirthday.day > today.day)) {
        newAge--;
      }
      _age = newAge;
      if (!maxHeartRatePersonalized) {
        await setMaxHeartRate();
      }
    }

    _username = _prefs.getString('username');
    notifyListeners();
    //birthday has to be converted to string to be save in sharedPreference!
    final birthdayString = "${newBirthday?.year}-${newBirthday?.month}-${newBirthday?.day}";
    if(username != null && username!.isNotEmpty){ 
      try{
        _birthday = newBirthday;
        await _prefs.setString(_key('birthday'), birthdayString);
        _age = newAge;
        await _prefs.setInt(_key('age'), newAge);
      } catch(e){
        print('Birthday is not valid: $e');

      }
    } else{_age = null;}
    notifyListeners();
  }

  Future<void> setHeight(int? newHeight) async {
    _height = newHeight;
    await _prefs.setInt(_key('height'), _height!);
    await setStepLength();
    notifyListeners();
  }

  Future<void> setWeight(double? newWeight) async {
    _weight = newWeight;
    await _prefs.setDouble(_key('weight'), _weight!);
    notifyListeners();
  }

  Future<void> setMaxHeartRatePersonalized(bool newValue) async {
    _maxHeartRatePersonalized = newValue;
    await _prefs.setBool(_key('maxHeartRate_personalized'), newValue);
    await setMaxHeartRate();
    notifyListeners();
  }

  Future<void> setMaxHeartRate({int? newValue}) async {
    if (newValue != null && _maxHeartRatePersonalized) {
      _maxHeartRate = newValue;
      await _prefs.setInt(_key('maxHeartRate'), _maxHeartRate!);
    } else if (!_maxHeartRatePersonalized && age != null) {
      _maxHeartRate = (208 - (0.7 * age!)).round();
      await _prefs.setInt(_key('maxHeartRate'), _maxHeartRate!);
    } else {
      _maxHeartRate = null;
      await _prefs.remove(_key('maxHeartRate'));
    }
    notifyListeners();
  }

  Future<void> setStepLengthPersonalized(bool newValue) async {
    _stepLengthPersonalized = newValue;
    await _prefs.setBool('stepLength_personalized', newValue);
    notifyListeners();
  }

  Future<void> setStepLength({int? newValue}) async {
    if (newValue != 0 && stepLengthPersonalized) {
      _stepLength = newValue;
      await _prefs.setInt(_key('stepLength'), _stepLength!);
    } else if (!stepLengthPersonalized && height != null) {
      _stepLength = (0.415 * (height ?? 0)).toInt();
      await _prefs.setInt(_key('stepLength'), _stepLength!);
    } else {
      _stepLength = null;
      await _prefs.remove(_key('stepLength'));
    }
    notifyListeners();
  }
}

