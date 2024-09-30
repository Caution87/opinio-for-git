import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:opinio/services/firestore.dart';

class PracticePage extends StatefulWidget {
  const PracticePage({super.key});

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  int opinion = 2; // Default opinion (neutral)
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController commentController = TextEditingController();

  void openCommentBox() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: commentController,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              firestoreService.addComment(commentController.text, opinion);
              //clear textfield
              commentController.clear();
              //pop
              Navigator.pop(context);
            },
            child: Text('Add'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('practice page'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: firestoreService.getCommentsStream(),
          builder: (context, snapshot) {
            //if we have data get docs
            if (snapshot.hasData) {
              List commentsList = snapshot.data!.docs;
              print(commentsList);
              //display list
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
                    //display as listTile
                    ListTile(
                      title: Text(commentText),
                      leading: Icon(Icons.star),
                    );
                  });
            } else {
              return const Text('Nothing to show');
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: openCommentBox,
        child: Icon(Icons.add),
      ),
    );
  }
}
