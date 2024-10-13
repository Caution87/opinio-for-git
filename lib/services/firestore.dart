import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  /*

  DEBATES

  */
  // Get current user
  User? user = FirebaseAuth.instance.currentUser;

  // Get collection of debates
  final CollectionReference debates =
      FirebaseFirestore.instance.collection('debates');

  // Read debate
  Stream<QuerySnapshot> getDebatesStream() {
    final debatesStream = FirebaseFirestore.instance
        .collection('debates')
        .orderBy('timestamp', descending: true)
        .snapshots();
    return debatesStream;
  }

  /*

  COMMENTS

  */
  // Get collection of comments for a specific debate
  Stream<QuerySnapshot> getCommentsStream(String debateId) {
    final commentsStream = FirebaseFirestore.instance
        .collection('debates')        // Correct the collection name to 'debates'
        .doc(debateId)                // Get the document by debateId
        .collection('comments')       // Access the 'comments' subcollection
        .orderBy('timestamp', descending: true)  // Order by timestamp
        .snapshots();                 // Return the real-time stream of comments
    return commentsStream;
  }
}

