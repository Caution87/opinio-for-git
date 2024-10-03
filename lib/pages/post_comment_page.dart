import 'package:flutter/material.dart';
import 'package:opinio/services/firestore.dart';

class PostCommentPage extends StatefulWidget {
  const PostCommentPage({super.key});

  @override
  State<PostCommentPage> createState() => _PostCommentPageState();
}

class _PostCommentPageState extends State<PostCommentPage> {
  final commentController = TextEditingController();
  final FirestoreService firestoreService = FirestoreService();
  int userOpinion = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Your Comment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: commentController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      userOpinion = 0;
                    });
                  },
                  child: Container(
                    child: Text('For'),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      userOpinion = 1;
                    });
                  },
                  child: Container(
                    child: Text('Against'),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    //Add comment
                    firestoreService.addComment(
                        commentController.text, userOpinion);
                    //clear textField
                    commentController.clear();
                  },
                  child: Text('Add'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
