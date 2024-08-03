import 'package:flutter/material.dart';
import 'package:platform_changer_app/model/interface_change_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InterfaceChangeProvider with ChangeNotifier {
  InterfaceChangeModel interfaceChangeModel = InterfaceChangeModel(isCupertino: false);


  InterfaceChangeProvider(){
    loadPrefs();
  }
  void changeInterface() {
    interfaceChangeModel.isCupertino = !interfaceChangeModel.isCupertino;
    setPrefs();
    notifyListeners();
  }

  Future<void> loadPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    interfaceChangeModel.isCupertino = prefs.getBool("isAndroid") ?? false;

    notifyListeners();
  }

  Future<void> setPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool("isAndroid", interfaceChangeModel.isCupertino);
  }
}
