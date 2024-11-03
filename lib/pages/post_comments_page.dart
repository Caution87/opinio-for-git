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

class _PostCommentsPageState extends State<PostCommentsPage> {
  final FirestoreService firestoreService = FirestoreService();
  //textController
  final commentController = TextEditingController();

  //current user
  final currentUser = FirebaseAuth.instance.currentUser!;

  //post debate
  void postComment(){
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
    }
    commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Your Comment"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            child: Text(currentUser.email!),
          ),
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
