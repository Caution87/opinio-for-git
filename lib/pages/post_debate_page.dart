import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:opinio/components/my_text_field.dart';
import 'package:opinio/pages/home1_page.dart';
import 'package:opinio/pages/home_page.dart';

class PostDebatePage extends StatefulWidget {
  const PostDebatePage({super.key});

  @override
  State<PostDebatePage> createState() => _PostDebatePageState();
}

class _PostDebatePageState extends State<PostDebatePage> {
  //textController
  final debateContentController = TextEditingController();

  //current user
  final currentUser = FirebaseAuth.instance.currentUser!;

  //post debate
  void postDebate() {
    if (debateContentController.text.isNotEmpty) {
      //store in firebase
      FirebaseFirestore.instance.collection("debates").add({
        'UserEmail': currentUser.email,
        'title': debateContentController.text,
        'timestamp': Timestamp.now(),
        'likes': [],
        'forOpinions': [],
        'againstOpinions': [],
        'likeCount': 0
      });
      Navigator.pop(context);
    }
    debateContentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Your Debate"),
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
                    controller: debateContentController,
                    hintText: "",
                    obscureText: false),
                ElevatedButton(onPressed: postDebate, child: Text("Post")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
