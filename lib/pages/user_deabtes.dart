import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opinio/components/debate_tile.dart';
import 'package:opinio/pages/debate_page.dart';
import 'package:opinio/services/firestore.dart';

class UserDeabtes extends StatefulWidget {
  const UserDeabtes({super.key});

  @override
  State<UserDeabtes> createState() => _UserDeabtesState();
}

class _UserDeabtesState extends State<UserDeabtes> {
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
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        // backgroundColor: Color.fromRGBO(32, 32, 32, 1),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
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
              stream: firestoreService.searchUserDebates(),
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
                        timestamp: DateFormat('MMM dd, yyyy')
                            .format(timestamp.toDate())
                            .toString(),
                        title: title,
                        likes: List<String>.from(debate['likes'] ?? []),
                        debateId: debate.id,
                        forOpinions:
                            List<String>.from(debate['forOpinions'] ?? []),
                        againstOpinions:
                            List<String>.from(debate['againstOpinions'] ?? []),
                        imageUrl: debate['imageUrl'] ??
                            '', // Dynamically fetch imageUrl
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
