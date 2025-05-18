import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier{

  /*
  HERE: Data from Fitbit
  */
  
  int step_count = 0; //to update step counter on homepage
  double step_length = 0.7; //avg step_length for a men ... in meters
  int step_weeklyGoal = 0; //changeable in settings



  DateTime currentDate = DateTime.now();
  //List<HR> heartRates = [];
  String name = 'username'; //user name as default value
  String surname = "";

  void update_settings(){
  //
  }

  void update_stepCounter(){
    //
  }
}