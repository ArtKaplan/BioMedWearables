import 'package:flutter/material.dart';
import 'package:the_app/utils/awards.dart';

class AwardProvider extends ChangeNotifier{
  List<Award> _awards = [];
  final AwardRepo _repo = AwardRepo();

  List<Award> get awards => _awards; //all awards - locked and unlocked

  List<Award> get unlockedAwards => _awards.where((award) => award.isUnlocked).toList();
  
  List<Award> get lockedAwards => _awards.where((award) => !award.isUnlocked).toList();

  Future<void> loadAwards() async{
    _awards = await _repo.loadAwards();
    notifyListeners();
  }

  void unlockAward(String awardID){
    final award = _awards.firstWhere((a) => a.id == awardID);
    award.isUnlocked = true;
    notifyListeners();
  }

}