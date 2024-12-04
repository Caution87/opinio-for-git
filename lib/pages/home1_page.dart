// ignore_for_file: sort_child_properties_last, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opinio/components/debate_tile.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:opinio/components/mycarousel.dart';
import 'package:opinio/pages/debate_page.dart';
import 'package:opinio/pages/post_debate_page.dart';
import 'package:opinio/pages/practice_page_comments.dart';
import 'package:opinio/pages/user_deabtes.dart';
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
  }

  String? valueChoose; // Use String? for null safety
  List<String> listItem = ["Most Liked", "Recent"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
          centerTitle: true,
          title: Text(
            "O P I N I O",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
          ),
          /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PostDebatePage()),
          );
        },
        child: Icon(Icons.add),
      ),*/
        ),
        drawer: Drawer(
          backgroundColor: Theme.of(context).colorScheme.surface,
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.red), //BoxDecoration
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
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    Text(
                      currentUser.email!,
                      style: TextStyle(color: Colors.black),
                    ),
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
                  Icons.settings,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                title: Text(
                  ' Settings ',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/settings_page');
                },
              ),
              Divider(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                title: Text(
                  ' My Debates ',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserDeabtes()));
                },
              ),
              Divider(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ],
          ),
        ),
        body: Column(children: [
          /*DropdownButton<String>(
            hint: Text(
              "Sort:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            value: valueChoose, // Can be null initially
            onChanged: (newValue) {
              setState(() {
                valueChoose = newValue; // Update selected value
              });
            },
            items: listItem.map((valueItem) {
              return DropdownMenuItem<String>(
                value: valueItem, // Value must match DropdownButton<String>
                child: Text(valueItem),
              );
            }).toList(),
          ),*/
          Expanded(
            child: StreamBuilder(
              stream: firestoreService.getDebatesStream(valueChoose),
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
                return Expanded(
                  child: ListView.builder(
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
                                debateId: debate.id,
                                title: title,
                                forOpinions: List<String>.from(
                                    debate['forOpinions'] ?? []),
                                againstOpinions: List<String>.from(
                                    debate['againstOpinions'] ?? []),
                                imageUrl: debate['imageUrl'] ?? '',
                              ), // Pass data to the next page
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
                          likes: List<String>.from(debate['likes'] ?? []),
                          debateId: debate.id,
                          forOpinions:
                              List<String>.from(debate['forOpinions'] ?? []),
                          againstOpinions: List<String>.from(
                              debate['againstOpinions'] ?? []),
                          imageUrl: debate['imageUrl'] ?? '',
                          timestamp: DateFormat('MMM dd, yyyy')
                              .format(timestamp.toDate())
                              .toString(), // Dynamically fetch imageUrl
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          )
        ]));
  }
}
          /*ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount:
                widget.news == "Breaking" ? sliders.length : rticles.length,
            itemBuilder: (context, index) {
              print(articles.length);
              print(sliders.length);
              return AllNewsSection(
                  Image: widget.news == "Breaking"
                      ? sliders[index].urlToImage!
                      : articles[index].urlToImage!,
                  desc: widget.news == "Breaking"
                      ? sliders[index].description!
                      : articles[index].description!,
                  title: widget.news == "Breaking"
                      ? sliders[index].title!
                      : articles[index].title!,
                  url: widget.news == "Breaking"
                      ? sliders[index].url!
                      : articles[index].url!);
            }),*/

