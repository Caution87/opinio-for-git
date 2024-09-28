// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:opinio/components/liked_comment_tile.dart';

class LikedCommentsPage extends StatelessWidget {
   LikedCommentsPage({super.key});
  List likedComments = [
    'These are the liked comments by the user.',
    "These comments don't have an opinion property",
    'They are grey[800] in dark mode',
    'They will be another color in light mode. This comment is elaborated in order to check new line. To make the comments of different lenghts or sizes',
    'The comments will have a different color in light mode',
    'Comments should be renamed to opinions and I believe many things in this app need to be renamed',
    'I also believe we need a Light Mode',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        title: Text(
          "O P I N I O",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          overflow: TextOverflow.visible, 
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: ListView.builder(
                itemCount: likedComments.length,
                itemBuilder: (context, index) {
                  return LikedCommentTile(
                    comment: likedComments[index],
                  );
                }),
    );
  }
}
