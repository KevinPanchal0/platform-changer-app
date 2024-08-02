import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/theme_toggle_model.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeModel themeModel = ThemeModel(isDark: false);

  ThemeProvider() {
    // get the value of key, initialize it with "false" value if it is not set yet
    loadPrefs();
  }

  void changeTheme() {
    themeModel.isDark = !themeModel.isDark; // toggle operation

    // set the key with the value of the updated themeModel.isDark
    setPrefs();

    notifyListeners();
  }

  Future<void> loadPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    themeModel.isDark = prefs.getBool("isDark") ?? false;

    notifyListeners();
  }

  Future<void> setPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool("isDark", themeModel.isDark);
  }
}