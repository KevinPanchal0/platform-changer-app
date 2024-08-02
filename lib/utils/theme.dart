import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeToggle{
  final ThemeData lightTheme = ThemeData.light();
  final ThemeData darkTheme = ThemeData.dark();
  final CupertinoThemeData lightThemeCupertino =const CupertinoThemeData(
    applyThemeToAll: true,
    brightness: Brightness.light
  );
  final CupertinoThemeData darkThemeCupertino =const CupertinoThemeData(
    applyThemeToAll: true,

    brightness: Brightness.dark
  );

  }