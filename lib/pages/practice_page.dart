// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:opinio/components/comment_tile.dart';
import 'package:opinio/pages/post_comment_page.dart';
import 'package:opinio/services/firestore.dart';

class PracticePage extends StatefulWidget {
  const PracticePage({super.key});

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  final FirestoreService firestoreService = FirestoreService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pratice Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostCommentPage()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: firestoreService.getCommentsStream(),
          builder: (context, snapshot) {
            //check if we have data
            if (snapshot.hasData) {
              List commentsList = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: commentsList.length,
                  itemBuilder: (context, index) {
                    //get each doc
                    DocumentSnapshot document = commentsList[index];
                    String docID = document.id;
                    //get comment form each doc
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    String commentText = data['comment_content'];
                    //display
                    // return ListTile(
                    //   title: Text(commentText),
                    // );
                    return CommentTile(
                        comment: commentText, opinion: 0, likes: []);
                  });
            } else {
              return Text("No Comments");
            }
          }),
    );
  }
}
