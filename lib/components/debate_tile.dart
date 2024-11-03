// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:opinio/components/like_button.dart';
import 'package:opinio/pages/debate_page.dart';

class DebateTile extends StatefulWidget {
  final String title;
  final String imagePath;
  final String debateId;
  final int likes; //0 is for 1 is against 2 is neutral
  DebateTile({
    super.key,
    required this.title,
    required this.imagePath,
    required this.likes, required this.debateId,
  });

  @override
  State<DebateTile> createState() => _DebateTileState();
}

class _DebateTileState extends State<DebateTile> {
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
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DebatePage(
                  imagePath: "lib/Opinio_Images/Global_Warming.jpg",
                  title: widget.title,
                  debateId: widget.debateId,
                )));
      },
      child: Column(
        children: [
          //Gap between tiles
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            //Container containing image and title
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                // color: Color.fromRGBO(32, 32, 32, 1),
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image container
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      width: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image: DecorationImage(
                          image: AssetImage(widget.imagePath),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  // Text Container
                  Expanded(
                    // Wrap Text with Expanded
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                          //So that text goes to new line
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ),
                  ),
                  //Like Button
                  Column(
                    children: [
                      SizedBox(
                        height: 70,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LikeButton(
                          size: 24,
                          likeCount: widget.likes,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
