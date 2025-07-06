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

  //List<Award> _awards = [];
  //final AwardRepo _repo = AwardRepo();
  List<Award> get awards => _awards; //all awards - locked and unlocked
  List<Award> get unlockedAwards => _awards.where((award) => award.isUnlocked).toList();
  List<Award> get lockedAwards => _awards.where((award) => !award.isUnlocked).toList();


  String? _username;
  String? get username => _username;

  Future<void> init({String? user}) async{
    _username = sp.getString('username') ?? 'default';
    print('INIT: username = $_username');
    await loadAwardsUser(_username!);
  }
/*
  Future<void> loadAwards() async{
    _awards = await _repo.loadAwards();
    //_checkAllConditions();
    notifyListeners();

    if(username == null || username == 'default'){
      //load default
        _steps20k = false;
        _steps30k = false;
        _steps40k = false;
        _steps50k = false;

        notifyListeners();
    } else{
      _steps20k = sp.getBool(_key('steps20k')) ?? false;
      _steps30k = sp.getBool(_key('steps30k')) ?? false;
      _steps40k = sp.getBool(_key('steps40k')) ?? false;
      _steps50k = sp.getBool(_key('steps50k')) ?? false;

      notifyListeners();
    }
  }
*/
  Future<void> loadAwardsUser(String username) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String key = '$_keyPrefix$username';

    final String? storedData = sp.getString(key);
    print('loadAwardsUser: key = $key');

    if (storedData != null) {
      _awards = Award.decode(storedData);
      print('loadAwardsUser: storedData != null: awards = $_awards');
    } else {
      final String jsonString = await rootBundle.loadString('lib/utils/awards.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      _awards = jsonList.map((item) => Award.fromJson(item)).toList();
      await sp.setString(key, Award.encode(_awards));
      print('loadAwardsUser: storedData == null: awards = $_awards');
    }

    notifyListeners();

    //check if awardss are still valid
    if (_stepsProvider != null) {
      await checkStepAwards(_stepsProvider!);
      print('loadAwardsUser: checkStepAwards DONE');
      notifyListeners();
    }
    if (_hikeProvider != null) {
      await _hikeProvider!.checkAllHikeAwards();
      print('loadAwardsUser: checkAllHikeAwards DONE');
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
      print('key = $key, unlocked = ${Award.encode(_awards)}');

      notifyListeners();
    }
  }

  Future<void> checkStepAwards(StepsProvider stepsProvider) async {
    print('checkStepAwards: START');
    final stepsList = await stepsProvider.getStepsEachDay();

    print('StepsList in checkStepAwards: $stepsList');

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
      print('Checking $id with target $target -> hasReachedTarget = $hasReachedTarget');


      final index = _awards.indexWhere((a) => a.id == id);
      if (index != -1) {
        if (_awards[index].isUnlocked != hasReachedTarget) {
          _awards[index].isUnlocked = hasReachedTarget;
          final String key = '$_keyPrefix${_username!}';
          await sp.setString(key, Award.encode(_awards));
          print('checkStepAwards: key = $key, isUnlocked = ${_awards[index].isUnlocked}');
          notifyListeners();
        }
      }
    }
    print('checkStepAwards: ENDE');
  }
  
  /*
  bool isAwardUnlocked(String id) {
    final award = _awards.firstWhere((a) => a.id == id, orElse: () => Award(id: id, title: '', category: '', imagePath: '', condition: '', isUnlocked: false));
    return award.isUnlocked;
  }
  */

  //String _key(String baseKey) {
  //  if (username != null && username!.isNotEmpty){
  //    //print('_key: Key = ${username}_$baseKey');
  //    return '${username}_$baseKey';
  //  } else{
  //    //print('_key: Key = $baseKey');
  //    return baseKey;
  //  }
  //}
/*
  /// function to proof if target nr of steps for award have been reached
  /// get steplist, search for da with >=x steps
  /// if found: flip bool in json file of award to TRUE  
  Future<void> condition_xStepsDone(String awardID, int stepTarget) async{
    final xStepsDone = stepsProvider.stepsEachDay.any((day) => day.value >= stepTarget);
    _updateAwardStatus(awardID, xStepsDone);
  }
  
  void _checkAllConditions(){
    condition_xStepsDone('steps_20k', 20000);
    condition_xStepsDone('steps_30k', 30000);
    condition_xStepsDone('steps_40k', 40000);
    condition_xStepsDone('steps_50k', 50000);
  }

  void _updateAwardStatus(String id, bool isUnlocked){
    final award = _awards.firstWhere((aw) => aw.id == id);
    award.isUnlocked = isUnlocked;
    notifyListeners();
  }*/
}