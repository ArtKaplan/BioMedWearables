import 'package:flutter/material.dart';
import 'package:the_app/utils/awards.dart';
import 'package:the_app/provider/stepsProvider.dart';

class AwardProvider extends ChangeNotifier{
  final StepsProvider stepsProvider;
  AwardProvider(this.stepsProvider);

  List<Award> _awards = [];
  final AwardRepo _repo = AwardRepo();

  List<Award> get awards => _awards; //all awards - locked and unlocked

  List<Award> get unlockedAwards => _awards.where((award) => award.isUnlocked).toList();
  
  List<Award> get lockedAwards => _awards.where((award) => !award.isUnlocked).toList();

  Future<void> loadAwards() async{
    _awards = await _repo.loadAwards();
    //_checkAllConditions();
    notifyListeners();
  }
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