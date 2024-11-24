import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class FirestoreService {
  /*

  DEBATES

  */
  // Get current user
  User? user = FirebaseAuth.instance.currentUser;

  // Get collection of debates
  Stream<QuerySnapshot> getDebatesStream(String? sortBy) {
    CollectionReference debatesRef =
        FirebaseFirestore.instance.collection('debates');

    if (sortBy == "Most Liked") {
      // Sort by likes (assuming you have a 'likeCount' field)
      return debatesRef.orderBy('likeCount', descending: true).snapshots();
    } else {
      // Default to sorting by timestamp
      return debatesRef.orderBy('timestamp', descending: true).snapshots();
    }
  }

  /*

  COMMENTS

  */
  // Get collection of comments for a specific debate
  // Stream<QuerySnapshot> getCommentsStream(String debateId) {
  //   final commentsStream = FirebaseFirestore.instance
  //       .collection('debates')        // Correct the collection name to 'debates'
  //       .doc(debateId)                // Get the document by debateId
  //       .collection('comments')       // Access the 'comments' subcollection
  //       .orderBy('timestamp', descending: true)  // Order by timestamp
  //       .snapshots();                 // Return the real-time stream of comments
  //   return commentsStream;
  // }

  Stream<QuerySnapshot> getCommentsStream(String debateId, String? sortBy) {
    CollectionReference commentsRef = FirebaseFirestore.instance
        .collection('debates')
        .doc(debateId)
        .collection('comments');

    if (sortBy == "Most Liked") {
      return commentsRef.orderBy('likeCount', descending: true).snapshots();
    } else if (sortBy == "Recent") {
      return commentsRef.orderBy('timestamp', descending: true).snapshots();
    } else if (sortBy == "For") {
      return commentsRef
          .where('opinion', isEqualTo: 0) // Filter for "For"
          .orderBy('opinion') // Order by 'opinion' first
          .orderBy('timestamp', descending: true) // Then order by 'timestamp'
          .snapshots();
    } else if (sortBy == "Against") {
      return commentsRef
          .where('opinion', isEqualTo: 1) // Filter for "Against"
          .orderBy('opinion') // Order by 'opinion' first
          .orderBy('timestamp', descending: true) // Then order by 'timestamp'
          .snapshots();
    } else if (sortBy == "Neutral") {
      return commentsRef
          .where('opinion', isEqualTo: -1) // Filter for "Neutral"
          .orderBy('opinion') // Order by 'opinion' first
          .orderBy('timestamp', descending: true) // Then order by 'timestamp'
          .snapshots();
    } else {
      return commentsRef.orderBy('timestamp', descending: true).snapshots();
    }
  }

//search function
  final FirebaseFirestore _db = FirebaseFirestore.instance;

// Function to search debates by title
  Stream<QuerySnapshot> searchDebates(String query) {
    return _db
        .collection('debates')
        .where('title', isGreaterThanOrEqualTo: query)
        .where('title', isLessThanOrEqualTo: '$query\uf8ff')
        .orderBy('title')
        .snapshots();
  }

Stream<QuerySnapshot> searchUserDebates() {
  return _db
      .collection('debates')
      .where('UserEmail', isEqualTo: user?.email) // Filter by current user
      .snapshots();
}

Stream<QuerySnapshot> getLikedDebates() {
  return _db
      .collection('debates')
      .where('likes', arrayContains: user?.email) // Check if the current user's email is in the 'likes' array
      .snapshots();
}



Future<int> getCommentCount(String debateId) async {
  try {
    final commentsSnapshot = await FirebaseFirestore.instance
        .collection('debates')
        .doc(debateId)
        .collection('comments')
        .get();

    return commentsSnapshot.docs.length; // Total number of comments
  } catch (e) {
    print('Error fetching comments: $e');
    return 0;
  }
}


}
