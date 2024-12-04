import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.red,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.red,
    unselectedItemColor: Colors.black,
  ),
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade200,
    primary: Colors.grey.shade300,
    secondary: Colors.white,
    inversePrimary: Colors.black,
  ),
);
