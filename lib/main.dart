// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:opinio/pages/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:opinio/pages/change_profile_page.dart';
import 'package:opinio/pages/debate_page.dart';
import 'package:opinio/pages/env_loader.dart';
import 'package:opinio/pages/home1_page.dart';
import 'package:opinio/pages/home_page.dart';
import 'package:opinio/pages/liked_comments_page.dart';
import 'package:opinio/pages/liked_debates_page.dart';
import 'package:opinio/pages/search_page.dart';
import 'package:opinio/pages/settings_page.dart';
import 'package:opinio/pages/stats_page.dart';
import 'package:opinio/pages/summary_page.dart';
import 'package:opinio/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Load environment variables (e.g., API key)
  await Env.load();

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
      routes: {
        '/auth_page': (context) => AuthPage(),
        '/home1_page': (context) => Home1Page(),
        '/home_page': (context) => HomePage(),
        '/settings_page': (context) => SettingsPage(),
        '/search_page': (context) => SearchPage(),
        // '/debate_page' : (context) => DebatePage(imagePath: null,),
        '/liked_comments_page': (context) => LikedCommentsPage(),
        '/liked_debates_page': (context) => LikedDebatesPage(
              imagePath: '',
              title: '',
            ),
        '/change_profile_page': (context) => ChangeProfilePage(),
        // '/stats_page' : (context) => StatsPage(imagePath: '', title: '', name: '',),
        // '/summary_page' : (context) => Summarypage(imagePath: '', title: '', name: '',),
      },
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
