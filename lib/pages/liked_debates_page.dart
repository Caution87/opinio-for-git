import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opinio/components/debate_tile.dart';
import 'package:opinio/pages/debate_page.dart';
import 'package:opinio/services/firestore.dart';

class LikedDebatesPage extends StatefulWidget {
  final String title;
  final String imagePath;
  LikedDebatesPage({super.key, required this.title, required this.imagePath});

  @override
  State<LikedDebatesPage> createState() => _LikedDebatesPageState();
}

class _LikedDebatesPageState extends State<LikedDebatesPage> {
  List<List<String>> likedDebates = [
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


    final FirestoreService firestoreService = FirestoreService();
  //user
  final currentUser = FirebaseAuth.instance.currentUser!;
  
  String? valueChoose; // Use String? for null safety
  List<String> listItem = ["Most Liked", "Recent"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        title: Text(
          "O P I N I O",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          overflow: TextOverflow.visible,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body:Column(
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
              stream: firestoreService.getLikedDebates(),
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
                            '',
                            timestamp: DateFormat('MMM dd, yyyy')
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
