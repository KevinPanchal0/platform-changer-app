import 'package:flutter/material.dart';
import 'package:platform_changer_app/model/bottom_tab_model.dart';

class BottomTabProvider with ChangeNotifier{
  BottomTabModel bottomTabModel = BottomTabModel();

  void changeIndex({required index}){
    bottomTabModel.currentIndex = index;
    notifyListeners();
  }
}