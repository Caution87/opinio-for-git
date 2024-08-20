import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:opinio/components/debate_tile.dart';

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
    [
      'The new Samsung Galaxy Book Edge is worth it.',
      'lib/Opinio_Images/Samsung-Galaxy-Book-4-series-official-2-jpg.webp'
    ],
    [
      'South Indian Food is the best cuisine.',
      'lib/Opinio_Images/south indian food.jpg'
    ],
    ['Mahesh Babu is a gifted actor.', 'lib/Opinio_Images/Mahesh-Babu.jpg'],
    [
      "Vinesh Phogat shouldn't have been disqualified.",
      'lib/Opinio_Images/Vinesh Phogat.jpg'
    ],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Colors.black,
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          "O P I N I O",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        // backgroundColor: Color.fromRGBO(32, 32, 32, 1),
        backgroundColor: Colors.black,
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
        backgroundColor: Colors.grey[900],
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
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    backgroundColor: Colors.black,
                  ),
                  Text(currentUser.email!),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.favorite, color: Colors.white),
              title: const Text(
                ' Liked Comments ',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/liked_comments_page');
              },
            ),
            Divider(),
            ListTile(
              leading: const Icon(
                Icons.favorite,
                color: Colors.white,
              ),
              title: const Text(
                ' Liked Debates ',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/liked_debates_page');
              },
            ),
            Divider(),
            ListTile(
              leading: const Icon(
                Icons.ads_click,
                color: Colors.white,
              ),
              title: const Text(
                ' Recently Viewed Debates ',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/liked_debates_page');
              },
            ),
            Divider(),
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.white),
              title: const Text(
                ' Change Profile ',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/change_profile_page');
              },
            ),
            Divider(),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: debateTiles.length,
        itemBuilder: (context, index) {
          return DebateTile(
            title: debateTiles[index][0],
            imagePath: debateTiles[index][1],
          );
        },
      ),
    );
  }
}
