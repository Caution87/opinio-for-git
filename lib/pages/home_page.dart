import 'package:flutter/material.dart';
import 'package:opinio/pages/home1_page.dart';
import 'package:opinio/pages/post_debate_page.dart';
import 'package:opinio/pages/search_page.dart';
import 'package:opinio/pages/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<List<String>> debateTiles = [
    [
      "Global Warming is the major problem to face this century.",
      'lib/Opinio_Images/Global_Warming.jpg'
    ],
    ["Anti-litter laws need to be stricter", 'lib/Opinio_Images/litter.jpg'],
    ["Lewis Hamilton should retire.", 'lib/Opinio_Images/lewis_hamilton.jpg'],
    [
      "CGPA is a determining factor for placements.",
      'lib/Opinio_Images/CGPA.jpg'
    ],
  ];
  int index = 0;

  void navigateBottomBar(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  final List<Widget> pages = [
    Home1Page(),
    PostDebatePage(),
    SearchPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: navigateBottomBar,
          backgroundColor:
              Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          selectedItemColor:
              Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
          unselectedItemColor:
              Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'NEW'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'SEARCH'),
          ]),
      body: pages[index],
    );
  }
}
