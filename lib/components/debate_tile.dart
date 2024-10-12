// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:opinio/components/like_button.dart';
import 'package:opinio/pages/debate_page.dart';

class DebateTile extends StatefulWidget {
  final String title;
  final String imagePath;
  final int index;
  final int likes;
  final String statement;
  final int opinion;//0 is for 1 is against 2 is neutral
  DebateTile(
      {super.key,
      required this.title,
      required this.imagePath,
      required this.index,
      required this.likes,
      required this.statement, required this.opinion});

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

  List<List<String>> debateTiles = [
    [
      "Global Warming is the major problem to face this century.",
      'lib/Opinio_Images/Global_Warming.jpg'
    ],
    ["Anti-litter laws need to be stricter", 'lib/Opinio_Images/litter.jpg'],
    ["Lewis Hamilton should retire.", 'lib/Opinio_Images/lewis_hamilton.jpg'],
    [
      "CGPA is a determining factor for placements.",
      'lib/Opinio_Images/CGPA.jpg'
    ],
    [
      'The new Samsung Galaxy Book Edge is worth it.',
      'lib/Opinio_Images/Samsung-Galaxy-Book-4-series-official-2-jpg.webp'
    ],
    [
      'South Indian Food is the best cuisine.',
      'lib/Opinio_Images/south indian food.jpg'
    ],
    ['Mahesh Babu is a gifted actor.', 'lib/Opinio_Images/Mahesh-Babu.jpg'],
    [
      "Vinesh Phogat shouldn't have been disqualified.",
      'lib/Opinio_Images/Vinesh Phogat.jpg'
    ],
  ];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DebatePage(
                  imagePath: debateTiles[widget.index][1],
                  statement: debateTiles[widget.index][0],
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
