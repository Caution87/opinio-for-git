import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:opinio/components/comment_icon.dart';
import 'package:opinio/pages/debate_page.dart';

class DebateTile extends StatefulWidget {
  final String title;
  final String imageUrl; // Updated: Dynamic image URL
  final String debateId;
  final List<String> likes;
  final List<String> forOpinions;
  final List<String> againstOpinions;
  final String timestamp;

  DebateTile({
    super.key,
    required this.title,
    required this.imageUrl, // Updated to accept dynamic image URL
    required this.likes,
    required this.debateId,
    required this.forOpinions,
    required this.againstOpinions,
    required this.timestamp,
  });

  @override
  State<DebateTile> createState() => _DebateTileState();
}

class _DebateTileState extends State<DebateTile> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

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

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  Future<bool> toggleLike(bool isCurrentlyLiked) async {
    setState(() {
      isLiked = !isCurrentlyLiked;
    });

    DocumentReference debateRef =
        FirebaseFirestore.instance.collection('debates').doc(widget.debateId);

    if (isLiked) {
      await debateRef.update({
        'likes': FieldValue.arrayUnion([currentUser.email]),
        'likeCount': FieldValue.increment(1),
      });
    } else {
      await debateRef.update({
        'likes': FieldValue.arrayRemove([currentUser.email]),
        'likeCount': FieldValue.increment(-1),
      });
    }

    return isLiked;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DebatePage(
                  title: widget.title,
                  debateId: widget.debateId,
                  forOpinions: widget.forOpinions,
                  againstOpinions: widget.againstOpinions,
                  imageUrl: widget.imageUrl,
                )));
      },
      child: Column(
        children: [
          SizedBox(height: screenHeight * 0.010),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                // Background container
                Container(
                  width: double.infinity,
                  height: screenHeight * 0.165,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Dynamic Image Container
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: screenHeight * 0.145,
                          width: screenWidth * 0.30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            image: DecorationImage(
                              image: widget.imageUrl.isNotEmpty
                                  ? NetworkImage(widget.imageUrl)
                                  : AssetImage(
                                          "lib/Opinio_Images/placeholder.png")
                                      as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      // Text Container (takes up remaining space)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.title,
                            style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                            ),
                            overflow: TextOverflow.ellipsis, // Avoid wrapping
                            maxLines: 3, // Limit to 3 lines
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Overlay the Like button and Comment icons
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.timestamp,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.28,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DebatePage(
                                  title: widget.title,
                                  debateId: widget.debateId,
                                  forOpinions: widget.forOpinions,
                                  againstOpinions: widget.againstOpinions,
                                  imageUrl: widget.imageUrl,
                                ),
                              ));
                            },
                            child: Row(
                              children: [
                                Icon(Icons.comment,
                                    size: 24, color: Colors.grey),
                                SizedBox(
                                  width: screenWidth * 0.01,
                                ),
                                FutureBuilder<int>(
                                  future: getCommentCount(widget.debateId),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return SizedBox(
                                        width: 15,
                                        height: 15,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('!');
                                    } else {
                                      return Text(
                                        '${snapshot.data ?? 0}',
                                        style: TextStyle(color: Colors.grey),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8),
                          LikeButton(
                            size: 24,
                            likeCount: widget.likes.length,
                            isLiked: isLiked,
                            onTap: (isLiked) async {
                              return toggleLike(isLiked);
                            },
                            likeBuilder: (isLiked) {
                              return Icon(
                                Icons.favorite,
                                color: isLiked ? Colors.pink : Colors.grey,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
        ],
      ),
    );
  }
}









 // Like Button
                  // Column(
                  //   children: [
                  //     SizedBox(height: screenHeight * 0.09),
                  //     Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Row(
                  //         children: [
                  //           CommentIcon(
                  //             onTap: () {
                  //               Navigator.of(context).push(MaterialPageRoute(
                  //                   builder: (context) => DebatePage(
                  //                         title: widget.title,
                  //                         debateId: widget.debateId,
                  //                         forOpinions: widget.forOpinions,
                  //                         againstOpinions:
                  //                             widget.againstOpinions,
                  //                         imageUrl: widget.imageUrl,
                  //                       )));
                  //             },
                  //           ),
                  //           FutureBuilder<int>(
                  //             future: getCommentCount(widget
                  //                 .debateId), // Call your async function here
                  //             builder: (context, snapshot) {
                  //               if (snapshot.connectionState ==
                  //                   ConnectionState.waiting) {
                  //                 return CircularProgressIndicator(); // Show a loading indicator while waiting
                  //               } else if (snapshot.hasError) {
                  //                 return Text('Error: ${snapshot.error}');
                  //               } else {
                  //                 final commentCount = snapshot.data ??
                  //                     0; // Use 0 if snapshot.data is null
                  //                 return Text('$commentCount');
                  //               }
                  //             },
                  //           ),
                  //           SizedBox(
                  //             width: screenWidth * 0.01,
                  //           ),
                  //           LikeButton(
                  //             size: 24,
                  //             likeCount: widget.likes.length,
                  //             isLiked: isLiked,
                  //             onTap: (isLiked) async {
                  //               return toggleLike(isLiked);
                  //             },
                  //             likeBuilder: (isLiked) {
                  //               return Icon(
                  //                 Icons.favorite,
                  //                 color: isLiked ? Colors.pink : Colors.grey,
                  //               );
                  //             },
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),








                  // LikeButton(
                  //                 size: 24,
                  //                 likeCount: widget.likes.length,
                  //                 isLiked: isLiked,
                  //                 onTap: (isLiked) async {
                  //                   return toggleLike(isLiked);
                  //                 },
                  //                 likeBuilder: (isLiked) {
                  //                   return Icon(
                  //                     Icons.favorite,
                  //                     color:
                  //                         isLiked ? Colors.pink : Colors.grey,
                  //                   );
                  //                 },
                  //               ),