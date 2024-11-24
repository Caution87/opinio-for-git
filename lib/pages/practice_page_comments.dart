// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opinio/pages/post_comments_page.dart';
import 'package:opinio/services/firestore.dart';

class PracticePageComments extends StatefulWidget {
  final String debateId;
  const PracticePageComments({super.key, required this.debateId});

  @override
  State<PracticePageComments> createState() => _PracticePageCommentsState();
}

class _PracticePageCommentsState extends State<PracticePageComments> {
  //getting currentUser
  final currentUser = FirebaseAuth.instance.currentUser!;
  //get access to firestore
  final FirestoreService firestoreService = FirestoreService();

  //initializing neutral opinion
  int opinion = 2; //0 is for 1 is against and 2 is neutral

  //making user opinion for
  void forOpinion() {
    setState(() {
      if (opinion != 0)
        opinion = 0;
      else
        opinion = 2;
    });
  }

  //making user opinion against
  void againstOpinion() {
    setState(() {
      if (opinion != 1)
        opinion = 1;
      else
        opinion = 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        // title: const Text("Practice Page Comments"),
        title: Text(currentUser.email!),
      ),
      floatingActionButton: FloatingActionButton(onPressed:()
      {Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostCommentsPage(debateId: widget.debateId) // Pass data to the next page
                    ),
                  );},
      child: Icon(Icons.add),),
      body: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: forOpinion,
                child: Container(
                  child: Center(
                      child: Text(
                    "FOR",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  )),
                  color: opinion == 0
                      ? Color.fromRGBO(68, 161, 160, 1)
                      : Color.fromRGBO(68, 161, 160, 0.5),
                  height: screenHeight * 0.05,
                  width: screenWidth * 0.5,
                ),
              ),
              GestureDetector(
                onTap: againstOpinion,
                child: Container(
                  child: Center(
                      child: Text(
                    "AGAINST",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  )),
                  color: opinion == 1
                      ? Color.fromRGBO(212, 77, 92, 1)
                      : Color.fromRGBO(212, 77, 92, 0.5),
                  height: screenHeight * 0.05,
                  width: screenWidth * 0.5,
                ),
              )
            ],
          ),
          // Expanded(
          //   child: StreamBuilder(
          //     stream: firestoreService
          //         .getCommentsStream(widget.debateId,null), // Use widget.debateId
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return const Center(child: CircularProgressIndicator());
          //       }

          //       if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          //         return const Center(child: Text("No comments yet."));
          //       }

          //       final comments = snapshot.data!.docs;

          //       return ListView.builder(
          //         itemCount: comments.length,
          //         itemBuilder: (context, index) {
          //           final comment = comments[index];
          //           String content = comment['content'];
          //           Timestamp timestamp = comment['timestamp'];

          //           return ListTile(
          //             title: Text(content),
          //             subtitle: Text(DateFormat('MMM dd, yyyy')
          //                 .format(timestamp.toDate())),
          //           );
          //         },
          //       );
          //     },
          //   ),
          // ),
          
        ],
      ),
    );
  }
}
