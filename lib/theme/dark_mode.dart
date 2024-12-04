import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    selectedItemColor: Colors.red,
    unselectedItemColor: Colors.white,
  ),
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    primary: Colors.grey.shade800,
    secondary: Colors.black,
    inversePrimary: Colors.white,
  ),
);