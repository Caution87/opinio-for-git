import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:opinio/components/my_text_field.dart';
import 'package:opinio/services/firestore.dart';

class PostCommentsPage extends StatefulWidget {
  final String debateId;
  const PostCommentsPage({super.key, required this.debateId});

  @override
  State<PostCommentsPage> createState() => _PostCommentsPageState();
}

final currentUser = FirebaseAuth.instance.currentUser!;
//get access to firestore
final FirestoreService firestoreService = FirestoreService();

bool _isSelectedFor = false;
bool _isSelectedAgainst = false;

class _PostCommentsPageState extends State<PostCommentsPage> {
  final FirestoreService firestoreService = FirestoreService();
  //textController
  final commentController = TextEditingController();
  void initState() {
    super.initState();
    //_isSelectedFor = widget.forOpinions.contains(currentUser.email!);
    //_isSelectedAgainst = widget.againstOpinions.contains(currentUser.email!);
  }

  void toggleFor() {
    setState(() {
      _isSelectedFor = !_isSelectedFor;
      if (_isSelectedAgainst) {
        _isSelectedAgainst = false;
      }
    });
  }

  void toggleAgainst() {
    setState(() {
      _isSelectedAgainst = !_isSelectedAgainst;
      if (_isSelectedFor) {
        _isSelectedFor = false;
      }
    });
  }

  //current user
  final currentUser = FirebaseAuth.instance.currentUser!;

  //post debate
  void postComment() {
    if (commentController.text.isNotEmpty) {
      //store in firebase
      FirebaseFirestore.instance
          .collection("debates")
          .doc(widget.debateId)
          .collection("comments")
          .add({
        'UserEmail': currentUser.email,
        'content': commentController.text,
        'timestamp': Timestamp.now(),
      });
      Navigator.pop(context);
    }
    commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Your Comment"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          //FOR OR AGAINST BUTTONS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () async => toggleFor(),
                child: Container(
                  width: screenWidth * 0.5,
                  color: _isSelectedFor
                      ? Color.fromRGBO(68, 161, 160, 1)
                      : Color.fromRGBO(68, 161, 160, 0.4),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
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
                onTap: () async => toggleAgainst(),
                child: Container(
                  width: screenWidth * 0.5,
                  color: _isSelectedAgainst
                      ? Color.fromRGBO(212, 77, 92, 1)
                      : Color.fromRGBO(212, 77, 92, 0.4),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "AGAINST",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          //Text(currentUser.email!),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                MyTextField(
                    controller: commentController,
                    hintText: "",
                    obscureText: false),
                ElevatedButton(onPressed: postComment, child: Text("Post")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
