import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_app/utils/awards.dart';
import 'package:the_app/provider/stepsProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:the_app/provider/hiketracking_provider.dart';

class AwardProvider extends ChangeNotifier{

  final SharedPreferences sp;
  AwardProvider(this.sp);

  StepsProvider? _stepsProvider;
  void setStepsProvider(StepsProvider provider) {
    _stepsProvider = provider;
  }

  HikeTracker? _hikeProvider;
  void setHikeProvider(HikeTracker provider) {
    _hikeProvider = provider;
  }

  final String _keyPrefix = 'awards_';
  late List<Award> _awards;

  List<Award> get awards => _awards; //all awards - locked and unlocked
  List<Award> get unlockedAwards => _awards.where((award) => award.isUnlocked).toList();
  List<Award> get lockedAwards => _awards.where((award) => !award.isUnlocked).toList();


  String? _username;
  String? get username => _username;

  Future<void> init({String? user}) async{
    _username = sp.getString('username') ?? 'default';
    await loadAwardsUser(_username!);
  }

  Future<void> loadAwardsUser(String username) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String key = '$_keyPrefix$username';

    final String? storedData = sp.getString(key);

    if (storedData != null) {
      _awards = Award.decode(storedData);
    } else {
      final String jsonString = await rootBundle.loadString('lib/utils/awards.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      _awards = jsonList.map((item) => Award.fromJson(item)).toList();
      await sp.setString(key, Award.encode(_awards));
    }

    notifyListeners();

    //check if awardss are still valid
    if (_stepsProvider != null) {
      await checkStepAwards(_stepsProvider!);
      notifyListeners();
    }
    if (_hikeProvider != null) {
      await _hikeProvider!.checkAllHikeAwards();
      notifyListeners();
    }
  }

  
  Future<void> unlockAward(String id, String username) async {
    final index = _awards.indexWhere((a) => a.id == id);
    if (index != -1 && !_awards[index].isUnlocked) {
      _awards[index].isUnlocked = true;

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String key = '$_keyPrefix$username';//username + _keyPrefix + id;
      await prefs.setString(key, Award.encode(_awards));

      notifyListeners();
    }
  }

  Future<void> checkStepAwards(StepsProvider stepsProvider) async {
    final stepsList = await stepsProvider.getStepsEachDay();

    final Map<String, int> awardsMap = {
      'steps_20k': 20000,
      'steps_30k': 30000,
      'steps_40k': 40000,
      'steps_50k': 50000,
    };

    for (var entry in awardsMap.entries) {
      final id = entry.key;
      final target = entry.value;

      final hasReachedTarget = stepsList.any((day) => day.value >= target);

      final index = _awards.indexWhere((a) => a.id == id);
      if (index != -1) {
        if (_awards[index].isUnlocked != hasReachedTarget) {
          _awards[index].isUnlocked = hasReachedTarget;
          final String key = '$_keyPrefix${_username!}';
          await sp.setString(key, Award.encode(_awards));
          notifyListeners();
        }
      }
    }
  }
}