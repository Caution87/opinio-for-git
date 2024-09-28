// ignore_for_file: sort_child_properties_last

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:opinio/components/debate_tile.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:opinio/components/mycarousel.dart';

class Home1Page extends StatefulWidget {
  const Home1Page({super.key});

  @override
  State<Home1Page> createState() => _Home1PageState();
}

class _Home1PageState extends State<Home1Page> {
  //user
  final currentUser = FirebaseAuth.instance.currentUser!;
  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
    // Navigate to login screen or show a message
  }

  List<List> carouselImages = [
    ["Laddoos", "lib/carousel_images/Laddo image.jpg"],
    [
      "Rowan Atkinson",
      "lib/carousel_images/file-photo-actor-rowan-atkinson-20110804-233218-383.jpg"
    ],
    ["Deadpool", "lib/carousel_images/deadpool.jpeg"],
  ];
  List<List> debateTiles = [
    [
      "Global Warming is the major problem to face this century.",
      'lib/Opinio_Images/Global_Warming.jpg',
      123
    ],
    [
      "Anti-litter laws need to be stricter",
      'lib/Opinio_Images/litter.jpg',
      23
    ],
    [
      "Lewis Hamilton should retire.",
      'lib/Opinio_Images/lewis_hamilton.jpg',
      80
    ],
    [
      "CGPA is a determining factor for placements.",
      'lib/Opinio_Images/CGPA.jpg',
      54
    ],
    [
      'The new Samsung Galaxy Book Edge is worth it.',
      'lib/Opinio_Images/Samsung-Galaxy-Book-4-series-official-2-jpg.webp',
      16
    ],
    [
      'South Indian Food is the best cuisine.',
      'lib/Opinio_Images/south indian food.jpg',
      87
    ],
    ['Mahesh Babu is a gifted actor.', 'lib/Opinio_Images/Mahesh-Babu.jpg', 3],
    [
      "Vinesh Phogat shouldn't have been disqualified.",
      'lib/Opinio_Images/Vinesh Phogat.jpg',
      887
    ],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Colors.black,
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        title: Text(
          "O P I N I O",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        // backgroundColor: Color.fromRGBO(32, 32, 32, 1),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ), //BoxDecoration
              // child: UserAccountsDrawerHeader(
              //   decoration: BoxDecoration(color: Colors.red),
              //   accountName: Text(
              //     "UserId",
              //     style: TextStyle(fontSize: 18),
              //   ),
              //   accountEmail: Text(currentUser.email!),
              //   currentAccountPictureSize: Size.square(50),
              //   currentAccountPicture: CircleAvatar(
              //     backgroundColor: Color.fromRGBO(32, 32, 32, 1),
              //     child: Text(
              //       "T",
              //       style: TextStyle(fontSize: 30.0, color: Colors.white),
              //     ),
              //   ),
              // ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    child: Text(
                      'T',
                      style: TextStyle(
                        fontSize: 30,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                  Text(currentUser.email!),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.favorite,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: Text(
                ' Liked Comments ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/liked_comments_page');
              },
            ),
            Divider(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            ListTile(
              leading: Icon(
                Icons.favorite,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: Text(
                ' Liked Debates ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/liked_debates_page');
              },
            ),
            Divider(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            ListTile(
              leading: Icon(
                Icons.ads_click,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: Text(
                ' Recently Viewed Debates ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/liked_debates_page');
              },
            ),
            Divider(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            ListTile(
              leading: Icon(
                Icons.edit,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: Text(
                ' Change Profile ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/change_profile_page');
              },
            ),
            Divider(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ],
        ),
      ),
      body:CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: 300,
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: carouselImages.length,
                itemBuilder: (context, index) {
                  return MyCarousel(
                    carouselTitle: carouselImages[index][0],
                    carouselImangePath: carouselImages[index][1],
                  );
                },
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return DebateTile(
                  title: debateTiles[index][0],
                  imagePath: debateTiles[index][1],
                  index: index,
                  likes: debateTiles[index][2],
                  statement: debateTiles[index][0],
                  opinion: 2,
                );
              },
              childCount: debateTiles.length,
            ),
          ),
        ],
      ),
    );
  }
}
