import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:the_app/provider/award_provider.dart';
import 'package:the_app/data/hike.dart';

class HikeTracker with ChangeNotifier {
  final SharedPreferences sp;
  AwardProvider? _awardProvider;
  HikeTracker(this.sp); 

  void setAwardProvider(AwardProvider awardProvider) {
    _awardProvider = awardProvider;
  }

  
  final String hikeCountKey = 'unique_hikes_done';
  final String hikeDataPrefix = 'hike_data_'; // uuse with hike name to store count/times

  String _key(String baseKey) {
    final _username = sp.getString('username');
    if (_username != null && _username.isNotEmpty){
      //print('_key: Key = ${username}_$baseKey');
      return '${_username}_$baseKey';
    } else{
      //print('_key: Key = $baseKey');
      return baseKey;
    }
  }

  Future<void> saveCompletedHike(String hikeName, Duration duration, double difficulty) async {
    final String key = _key(hikeDataPrefix + hikeName);
    print('saveCompletedHike: key = $key');
    final now = DateTime.now();
    
    // check if ccurrent data already excists 
    final hikeData = sp.getStringList(key) ?? [];
    final formattedDate = "${now.day.toString().padLeft(2,'0')}.${now.month.toString().padLeft(2,'0')}.${now.year}";
    print('saveCompleteHike: formatted date = $formattedDate');
    hikeData.add('$formattedDate|${duration.inSeconds.toString()}|$difficulty');
    //hikeData.add(duration.inSeconds.toString());
    await sp.setStringList(key, hikeData);
    print('saveCompleteHike: key = $key, hikeData = $hikeData)');

    // Track unique hike
    final uniqueHikes = sp.getStringList(_key(hikeCountKey)) ?? [];
    print('saveCompleteHike: is this hike already part of unique hikes done: ${!uniqueHikes.contains(hikeName)})');
    if (!uniqueHikes.contains(hikeName)) {
      uniqueHikes.add(hikeName);
      await sp.setStringList(_key(hikeCountKey), uniqueHikes);
    }
    notifyListeners();

    // necess. Check of hike awards --> possible hcanges
    await checkHikeAwards(hikeName, hikeData.length, uniqueHikes.length);

    notifyListeners();

  }

  Future<void> checkAllHikeAwards() async {
    final uniqueHikes = sp.getStringList(_key(hikeCountKey)) ?? [];
    print('checkAllHikeAwards: uniqueHikes = $uniqueHikes');

    for (final hikeName in uniqueHikes) {
      final timesDone = sp.getStringList(hikeDataPrefix + hikeName)?.length ?? 0;
      await checkHikeAwards(hikeName, timesDone, uniqueHikes.length);
    }
  }

  Future<void> checkHikeAwards(String hikeName, int timesDone, int totalUnique) async {
    final _username = sp.getString('username');
    if(_username != null && _awardProvider != null){
      if (timesDone == 3) {
        await _awardProvider!.unlockAward('samehike_3', _username);
      } else if (timesDone == 5) {
        _awardProvider!.unlockAward('samehike_5', _username);
      } else if (timesDone == 10) {
        _awardProvider!.unlockAward("samehike_10", _username);
      }

      if (totalUnique == 1) _awardProvider!.unlockAward('hike_1', _username);
      if (totalUnique == 5) _awardProvider!.unlockAward('hike_5', _username);
      if (totalUnique == 10) _awardProvider!.unlockAward('hike_10', _username);
      if (totalUnique == 15) _awardProvider!.unlockAward('hike_15', _username);
      if (totalUnique == hikelist.length) _awardProvider!.unlockAward('hike_all', _username);
    }
  }

  List<Duration> getTimesForHike(String hikeName) {
    final String key = hikeDataPrefix + hikeName;
    final hikeData = sp.getStringList(key) ?? [];
    return hikeData.map((e) => Duration(seconds: int.parse(e))).toList();
  }

  int getTimesCountForHike(String hikeName) {
    final String key = hikeDataPrefix + hikeName;
    return sp.getStringList(key)?.length ?? 0;
  }

  int getTotalUniqueHikesDone() {
    return sp.getStringList(hikeCountKey)?.length ?? 0;
  }

  List<Map<String, dynamic>> getDetailedTimesForHike(String hikeName) {
    final key = _key(hikeDataPrefix + hikeName);
    final hikeData = sp.getStringList(key) ?? [];
    print('hikeData = $hikeData');

    return List.generate(hikeData.length, (index) {
      final parts = hikeData[index].split('|');
      print('parts.length = ${parts.length}');
      // defensive check: if format is invalid, skip or provide fallback
      if (parts.length != 3) {
        return {
          'index': index + 1,
          'date': 'unknown',
          'duration': Duration.zero,
          'difficulty': 0.0,
        };
      }

      final date = parts[0];
      print('date = $date');
      final seconds = int.tryParse(parts[1]) ?? 0;
      final difficulty = parts[2];

      return {
        'index': index + 1,
        'date': date,
        'duration': Duration(seconds: seconds),
        'difficulty' : difficulty,
      };
    });
  }
}
