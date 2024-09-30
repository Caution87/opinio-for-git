import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
//get collection of comments

  final CollectionReference comments =
      FirebaseFirestore.instance.collection('comments');

//create comment
  Future<void> addComment(
    String comment,
    int opinion,
  ) {
    return FirebaseFirestore.instance.collection('comments').add({
      'comment_content': comment,
      'user_opinion': opinion,
      'timestamp': Timestamp.now(),
    });
  }

//read comment
  Stream<QuerySnapshot> getCommentsStream() {
    final commentsStream =
        comments.orderBy('timestamp', descending: true).snapshots();
    return commentsStream;
  }
//update comment

//delete comment
}
