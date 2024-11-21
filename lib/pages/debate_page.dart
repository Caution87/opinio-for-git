// ignore_for_file: prefer_const_constructors_in_immutables, unused_import, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opinio/components/against_button.dart';
import 'package:opinio/components/comment_tile.dart';
import 'package:opinio/components/debate_page_button.dart';
import 'package:opinio/components/forOrAgainstButton.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:opinio/components/for_button.dart';
import 'package:opinio/pages/post_comments_page.dart';
import 'package:opinio/services/firestore.dart';

class DebatePage extends StatefulWidget {
  final String debateId;
  final String imagePath;
  final String title;
  final List<String> forOpinions;
  final List<String> againstOpinions;
  const DebatePage({
    super.key,
    required this.debateId,
    required this.imagePath,
    required this.title,
    required this.forOpinions,
    required this.againstOpinions,
  });

  @override
  State<DebatePage> createState() => _DebatePageState();
}

class _DebatePageState extends State<DebatePage> {
  //getting currentUser
  final currentUser = FirebaseAuth.instance.currentUser!;
  //get access to firestore
  final FirestoreService firestoreService = FirestoreService();

  bool _isSelectedFor = false;
  bool _isSelectedAgainst = false;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    _isSelectedFor = widget.forOpinions.contains(currentUser.email!);
    _isSelectedAgainst = widget.againstOpinions.contains(currentUser.email!);
  }

  // void toggleFor() {
  //   setState(() {
  //     _isSelectedFor = !_isSelectedFor;
  //     if (_isSelectedAgainst) {
  //       _isSelectedAgainst = false;
  //     }
  //   });
  // }
  Future<void> toggleFor() async {
    // Toggle the selection
    bool newSelection = !_isSelectedFor;

    // Update the UI state
    setState(() {
      _isSelectedFor = newSelection;
      if (_isSelectedAgainst) {
        _isSelectedAgainst = false;
      }
    });

    // Firestore updates
    DocumentReference debateRef =
        FirebaseFirestore.instance.collection('debates').doc(widget.debateId);

    if (newSelection) {
      await debateRef.update({
        'forOpinions': FieldValue.arrayUnion([currentUser.email]),
        'againstOpinions': FieldValue.arrayRemove([currentUser.email]),
      });
    } else {
      await debateRef.update({
        'forOpinions': FieldValue.arrayRemove([currentUser.email]),
      });
    }
  }

  Future<void> toggleAgainst() async {
    // Toggle the selection
    bool newSelection = !_isSelectedAgainst;

    // Update the UI state
    setState(() {
      _isSelectedAgainst = newSelection;
      if (_isSelectedFor) {
        _isSelectedFor = false;
      }
    });

    // Firestore updates
    DocumentReference debateRef =
        FirebaseFirestore.instance.collection('debates').doc(widget.debateId);

    if (newSelection) {
      await debateRef.update({
        'againstOpinions': FieldValue.arrayUnion([currentUser.email]),
        'forOpinions': FieldValue.arrayRemove([currentUser.email]),
      });
    } else {
      await debateRef.update({
        'againstOpinions': FieldValue.arrayRemove([currentUser.email]),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        title: Text(
          "O P I N I O",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        // backgroundColor: Color.fromRGBO(32, 32, 32, 1),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/auth_page');
            },
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.inversePrimary,
              size: 36,
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PostCommentsPage(
                    debateId: widget.debateId) // Pass data to the next page
                ),
          );
        },
        child: Icon(Icons.add),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        //Till image to for against
        children: [
          //Image
          Container(
            height: 230,
            width: 430,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/Opinio_Images/Global_Warming.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),

          SizedBox(height: 10),
          // Statement
          // Text(widget.statement),
          // SizedBox(height: 10),
          Container(
              child: Text(
            widget.title,
            style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 16),
            textAlign: TextAlign.center,
          )),
          SizedBox(
            height: 10,
          ),
          //Opinion summary stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DebatePageButton(
                number: 0,
                shouldColor: true,
                imagePath: "lib/Opinio_Images/Global_Warming.jpg",
                name: 'OPINIONS',
                debateId: widget.debateId,
                title: widget.title,
                forOpinions: widget.forOpinions,
                againstOpinions: widget.againstOpinions,
              ),
              //Space
              const SizedBox(
                width: 5,
              ),
              DebatePageButton(
                imagePath: "lib/Opinio_Images/Global_Warming.jpg",
                title: widget.title,
                number: 1,
                shouldColor: false,
                name: 'SUMMARY',
                debateId: widget.debateId,
                forOpinions: widget.forOpinions,
                againstOpinions: widget.againstOpinions,
              ),
              const SizedBox(
                width: 5,
              ),
              DebatePageButton(
                imagePath: "lib/Opinio_Images/Global_Warming.jpg",
                number: 2,
                shouldColor: false,
                name: 'STATISTICS',
                debateId: widget.debateId,
                title: widget.title,
                forOpinions: widget.forOpinions,
                againstOpinions: widget.againstOpinions,
              ),
            ],
          ),
          const SizedBox(height: 10),
          //FOR OR AGAINST BUTTONS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () async => await toggleFor(),
                child: Container(
                  width: screenWidth * 0.5,
                  color: _isSelectedFor
                      ? Color.fromRGBO(68, 161, 160, 1)
                      : Color.fromRGBO(68, 161, 160, 0.4),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "FOR",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async => await toggleAgainst(),
                child: Container(
                  width: screenWidth * 0.5,
                  color: _isSelectedAgainst
                      ? Color.fromRGBO(212, 77, 92, 1)
                      : Color.fromRGBO(212, 77, 92, 0.4),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "AGAINST",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          //sort
          Row(
            children: [
              const SizedBox(
                width: 13,
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.sort,
                    color: Colors.red,
                    size: 30,
                  )),
              GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Sort',
                    style: TextStyle(color: Colors.red, fontSize: 22),
                  ))
            ],
          ),
          const Divider(
            color: Colors.red,
            indent: 20,
            endIndent: 20,
          ),
          // Comments
          Expanded(
            child: StreamBuilder(
              stream: firestoreService
                  .getCommentsStream(widget.debateId), // Use widget.debateId
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No comments yet."));
                }

                final comments = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    String content = comment['content'];
                    Timestamp timestamp = comment['timestamp'];
                    int col = comment['opinion'];
                    // return ListTile(
                    //   title: Text(content),
                    //   subtitle: Text(DateFormat('MMM dd, yyyy')
                    //       .format(timestamp.toDate())),
                    // );
                    return CommentTile(
                      timestamp: DateFormat('MMM dd, yyyy')
                          .format(timestamp.toDate())
                          .toString(),
                      opinion: col,
                      comment: content,
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
