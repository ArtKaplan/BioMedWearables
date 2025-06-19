import 'dart:convert';

import 'package:flutter/services.dart';


/// awards class to handle all listed awards from json file
///

class Award {
  //categories of awards.json file
  final String id;
  final String title;
  final String category; //hiking, steps, ...
  final String imagePath;
  final String condition; // just description not actual condition
  bool isUnlocked;

  Award({
    required this.id,
    required this.title,
    required this.category,
    required this.imagePath,
    required this.condition,
    required this.isUnlocked,
  });

  //to get info from json file
  factory Award.fromJson(Map<String, dynamic> json){
    return Award(
    id: json['id'] as String,
    title: json['title'] as String,
    category: json['category'] as String,
    imagePath: json['imagePath'] as String,
    condition: json['condition'] as String,
    isUnlocked: json['isUnlocked'] as bool
    );
  }
}

class AwardRepo{
  Future<List<Award>> loadAwards() async{
    final String jsonString = await rootBundle.loadString('lib/utils/awards.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => Award.fromJson(json)).toList();
  }
}