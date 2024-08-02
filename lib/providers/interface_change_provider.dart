import 'package:flutter/material.dart';
import 'package:platform_changer_app/model/interface_change_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InterfaceChangeProvider with ChangeNotifier {
  InterfaceChangeModel interfaceChangeModel = InterfaceChangeModel(isAndroid: false);


  InterfaceChangeProvider(){
    loadPrefs();
  }
  void changeInterface() {
    interfaceChangeModel.isAndroid = !interfaceChangeModel.isAndroid;
    setPrefs();
    notifyListeners();
  }

  Future<void> loadPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    interfaceChangeModel.isAndroid = prefs.getBool("isAndroid") ?? false;

    notifyListeners();
  }

  Future<void> setPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool("isAndroid", interfaceChangeModel.isAndroid);
  }
}
