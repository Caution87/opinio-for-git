// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:opinio/pages/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:opinio/pages/change_profile_page.dart';
import 'package:opinio/pages/debate_page.dart';
import 'package:opinio/pages/home1_page.dart';
import 'package:opinio/pages/home_page.dart';
import 'package:opinio/pages/liked_comments_page.dart';
import 'package:opinio/pages/liked_debates_page.dart';
import 'package:opinio/pages/search_page.dart';
import 'package:opinio/pages/settings_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthPage(),
      routes: {
        '/home1_page' : (context) => Home1Page(),
        '/home_page' : (context) => HomePage(),
        '/settings_page' : (context) => SettingsPage(),
        '/search_page' : (context) => SearchPage(),
        '/debate_page' : (context) => DebatePage(),
        '/liked_comments_page' : (context) => LikedCommentsPage(),
        '/liked_debates_page' : (context) => LikedDebatesPage(imagePath: '', title: '',),
        '/change_profile_page': (context) => ChangeProfilePage(),
      },
    );
  }
}
