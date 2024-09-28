import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:opinio/components/like_button.dart';

class LikedCommentTile extends StatefulWidget {
  final String comment;
   LikedCommentTile({super.key, required this.comment});

  @override
  State<LikedCommentTile> createState() => _LikedCommentTileState();
}

class _LikedCommentTileState extends State<LikedCommentTile> {
    final currentUser = FirebaseAuth.instance.currentUser!;

  bool isLiked = false;

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
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //text
                Expanded(
                    // Wrap Text with Expanded
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(
                          widget.comment,
                          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary,),
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
                  MyLikeButton(isLiked: isLiked, onTap: toggleLike),
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
