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
    // Navigate to login screen or show a message
  }

  String? valueChoose; // Use String? for null safety
  List<String> listItem = ["Most Liked", "Recent"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Colors.black,
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        title: Text(
          "O P I N I O",
          style: TextStyle(fontWeight: FontWeight.bold),
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
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PostDebatePage()),
          );
        },
        child: Icon(Icons.add),
      ),*/
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
      body: Column(
        children: [
          DropdownButton<String>(
            hint: Text("Sort:"),
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
          ),
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
                        againstOpinions:
                            List<String>.from(debate['againstOpinions'] ?? []),
                        imageUrl: debate['imageUrl'] ??
                            '', timestamp: DateFormat('MMM dd, yyyy')
                          .format(timestamp.toDate())
                          .toString(), // Dynamically fetch imageUrl
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


//added from services
// class FirestoreService {
//   /*

//   DEBATES

//   */
//   // Get current user
//   User? user = FirebaseAuth.instance.currentUser;

//   // Get collection of debates
//   final CollectionReference debates =
//       FirebaseFirestore.instance.collection('debates');

//   // Read debate
//   Stream<QuerySnapshot> getDebatesStream() {
//     final debatesStream = FirebaseFirestore.instance
//         .collection('debates')
//         .orderBy('timestamp',descending: true)
//         .snapshots();
//     return debatesStream;
//   }

//   /*

//   COMMENTS

//   */
//   // Get collection of comments for a specific debate
//   Stream<QuerySnapshot> getCommentsStream(String debateId) {
//     final commentsStream = FirebaseFirestore.instance
//         .collection('debates')        // Correct the collection name to 'debates'
//         .doc(debateId)                // Get the document by debateId
//         .collection('comments')       // Access the 'comments' subcollection
//         .orderBy('timestamp', descending: true)  // Order by timestamp
//         .snapshots();                 // Return the real-time stream of comments
//     return commentsStream;
//   }

//   //search function
//   final FirebaseFirestore _db = FirebaseFirestore.instance;

//   // Function to search debates by title
//   Stream<QuerySnapshot> searchDebates(String query) {
//     return _db
//         .collection('debates')
//         .where('title', isGreaterThanOrEqualTo: query)
//         .where('title', isLessThanOrEqualTo: '$query\uf8ff')
//         .orderBy('title')
//         .snapshots();
//   }
// }

