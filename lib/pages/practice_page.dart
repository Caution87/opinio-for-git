import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:opinio/components/debate_tile.dart';
import 'package:opinio/pages/post_debate_page.dart';
import 'package:opinio/pages/practice_page_comments.dart';
import 'package:opinio/services/firestore.dart';
import 'package:opinio/pages/post_comment_page.dart'; // Import the page you want to navigate to

class PracticePage extends StatefulWidget {
  const PracticePage({super.key});

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  final FirestoreService firestoreService = FirestoreService();
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice Page'),
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
                      builder: (context) => PracticePageComments(
                          debateId: debate.id), // Pass data to the next page
                    ),
                  );
                },
                // child: ListTile(
                //   title: Text(title),
                //   subtitle: Text(
                //       DateFormat('MMM dd, yyyy').format(timestamp.toDate())),
                // ),
                child: DebateTile(title: title, imagePath: "lib/Opinio_Images/Global_Warming.jpg",
                 likes: 100, statement: title, ),
              );
            },
          );
        },
      ),
    );
  }
}
