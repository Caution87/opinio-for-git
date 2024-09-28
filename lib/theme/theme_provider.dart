// ignore_for_file: prefer_final_fields, unused_field

import 'package:flutter/material.dart';
import 'package:opinio/theme/dark_mode.dart';
import 'package:opinio/theme/light_mode.dart';

/*
  THEME PROVIDER CHANGES APP FROM DARK MODE TO LIGHT MODE
*/

class ThemeProvider with ChangeNotifier {
  //Initially it is dark mode
  ThemeData _themeData = darkMode;

  //get current theme
  ThemeData get themeData => _themeData;

  //is it lightMode currently?
  bool get isLightMode => _themeData == lightMode;

  //set the theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;

    //update UI
    notifyListeners();
  }

  //toggle between dark and light mode
  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
