// ignore_for_file: unused_import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:opinio/components/like_button.dart';

class CommentTile extends StatefulWidget {
  final String comment;
  final int opinion; //0 is for 1 is against
  final List<String> likes;
  CommentTile(
      {super.key,
      required this.comment,
      required this.opinion,
      required this.likes});

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          color: widget.opinion == 0
              ? Color.fromRGBO(33, 158, 188, 1)
              : Color.fromRGBO(255, 80, 3, 1),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: widget.opinion == 0
                  ? Color.fromRGBO(33, 158, 188, 1)
                  : Color.fromRGBO(255, 80, 3, 1),
              spreadRadius: 2,
              blurRadius: 0.5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //text
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Container(
                  width: 300,
                   child: Expanded(
                     child: Text(
                       widget.comment,
                       style: TextStyle(color: Colors.white),
                       //So that text goes to new line
                       overflow: TextOverflow.visible, 
                     ),
                   ),
                 ),
               ),
              // Spacer(),
              //icon
              Column(
                children: [
                  //like button
                  LikeButton(isLiked: isLiked, onTap: toggleLike),
                  //like count
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
