import 'dart:convert';

/// awards class to handle all listed awards from json file
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
    this.isUnlocked = false,
    //required this.isUnlocked,
  });

  //to get info from json file
  factory Award.fromJson(Map<String, dynamic> json){
    return Award(
    id: json['id'] as String,
    title: json['title'] as String,
    category: json['category'] as String,
    imagePath: json['imagePath'] as String,
    condition: json['condition'] as String,
    isUnlocked: json['isUnlocked'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'imagePath': imagePath,
      'condition': condition,
      'isUnlocked': isUnlocked,
    };
  }

  static String encode(List<Award> awards) => json.encode(
    awards.map<Map<String, dynamic>>((a) => a.toJson()).toList(),

    //stackOverflow
    //award..map<Map<String, dynamic>>((award) => Award.toMap(award)).toList(),
  );

  static List<Award> decode(String awards) =>
    (json.decode(awards) as List<dynamic>)
        .map<Award>((item) => Award.fromJson(item))
        .toList();
    /*stackOverflow
    (json.decode(awards) as List<dynamic>)
          .map<Award>((item) => Award.fromJson(item))
          .toList();
    */
}