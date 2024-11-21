// ignore_for_file: unused_import, prefer_const_literals_to_create_immutables, body_might_complete_normally_nullable
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:opinio/components/like_button.dart';

class CommentTile extends StatefulWidget {
  final String comment;
  final String timestamp; //timestamp in date
  final int opinion; //0 is for 1 is against
  // final List<String> likes;
  CommentTile({
    super.key,
    required this.comment,
    required this.opinion,
    required this.timestamp,
    // required this.likes
  });

  @override
  State<CommentTile> createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;
  //created this override
  @override
  void initState() {
    super.initState();
  }

  //unlike and like
  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  Color? colorComment() {
    if (widget.opinion == 0) {
      return Color.fromRGBO(68, 161, 160, 1);
    } else if (widget.opinion == 1) {
      return Color.fromRGBO(212, 77, 92, 1);
    } else {
      return Theme.of(context).colorScheme.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          // color: widget.opinion == 0
          //     ? Color.fromRGBO(68,161,160,1)
          //     : Color.fromRGBO(212,77,92,1),
          color: colorComment(),
          borderRadius: BorderRadius.circular(8),
          /*boxShadow: [
            BoxShadow(
              /*color: widget.opinion == 0
                  ? Color.fromRGBO(68, 161, 160, 1)
                  : Color.fromRGBO(212, 77, 92, 1),*/
              spreadRadius: 2,
              blurRadius: 0.5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],*/
        ),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween, // Space between comment and like button
              children: [
                // Text Column
                Expanded(
                  // Allows text to take up remaining space
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Aligns text to the left
                    children: [
                      // The comment
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.comment,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      // The timestamp
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
                    ],
                  ),
                ),
                // Like Button
                LikeButton(
                  size: 24,
                ),
              ],
            )),
      ),
    );
  }
}
