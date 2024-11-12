// ignore_for_file: sort_child_properties_last, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:opinio/components/debate_tile.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:opinio/components/mycarousel.dart';
import 'package:opinio/pages/debate_page.dart';
import 'package:opinio/pages/post_debate_page.dart';
import 'package:opinio/pages/practice_page_comments.dart';
import 'package:opinio/services/firestore.dart';

class Home1Page extends StatefulWidget {
  const Home1Page({super.key});

  @override
  State<Home1Page> createState() => _Home1PageState();
}

class _Home1PageState extends State<Home1Page> {
  final FirestoreService firestoreService = FirestoreService();
  //user
  final currentUser = FirebaseAuth.instance.currentUser!;
  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
    // Navigate to login screen or show a message
  }

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
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PostDebatePage()),
          );
        },
        child: Icon(Icons.add),
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
      body: StreamBuilder(
        stream: firestoreService.getDebatesStream(),
        builder: (context, snapshot) {
          // Show loading circle while waiting
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Get all debates from Firestore
          final debates = snapshot.data!.docs;

          // Return as a ListView
          return ListView.builder(
            itemCount: debates.length,
            itemBuilder: (context, index) {
              // Get each debate
              final debate = debates[index];
              // Get data from each debate
              String title = debate['title'];
              Timestamp timestamp = debate['timestamp'];
              //get debate id

              // Return as a ListTile with GestureDetector
              return GestureDetector(
                onTap: () {
                  // Navigate to another page on tap
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DebatePage(
                          debateId: debate.id, imagePath: "lib/Opinio_Images/Global_Warming.jpg", title: title, forOpinions: List<String>.from(debate['forOpinions']??[]), againstOpinions: List<String>.from(debate['againstOpinions']??[]),), // Pass data to the next page
                    ),
                  );
                },
                // child: ListTile(
                //   title: Text(title),
                //   subtitle: Text(
                //       DateFormat('MMM dd, yyyy').format(timestamp.toDate())),
                // ),
                child: DebateTile(
                  title: title,
                  imagePath: "lib/Opinio_Images/Global_Warming.jpg",
                  likes: List<String>.from(debate['likes']??[]), debateId: debate.id, forOpinions: List<String>.from(debate['forOpinions']??[]), againstOpinions: List<String>.from(debate['againstOpinions']??[]),
                  
                ),
              );
            },
          );
        },
      ),
    );
  }
}
