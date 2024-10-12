// ignore_for_file: prefer_const_constructors_in_immutables, unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:opinio/components/against_button.dart';
import 'package:opinio/components/comment_tile.dart';
import 'package:opinio/components/debate_page_button.dart';
import 'package:opinio/components/forOrAgainstButton.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:opinio/components/for_button.dart';

class DebatePage extends StatefulWidget {
  final String imagePath;
  final String statement;
  DebatePage({super.key, required this.imagePath, required this.statement});

  @override
  State<DebatePage> createState() => _DebatePageState();
}

class _DebatePageState extends State<DebatePage> {
  var _isSelectedFor = false;
  var _isSelectedAgainst = false;
  List<List> comments = [
    //0 is for 1 is against
    [
      'These are the liked comments by the user. No they are not, they are regular comments.',
      0
    ],
    ["These comments don't have an opinion property", 1],
    ['They are grey[800] in dark mode', 0],
    [
      'They will be another color in light mode. This comment is elaborated in order to check new line. To make the comments of different lenghts or sizes',
      1
    ],
    ['The comments will have a different color in light mode', 0],
    [
      'Comments should be renamed to opinions and I believe many things in this app need to be renamed',
      0
    ],
    ['I also believe we need a Light Mode', 1],
  ];

  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        title: Text(
          "O P I N I O",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        // backgroundColor: Color.fromRGBO(32, 32, 32, 1),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/auth_page');
            },
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.inversePrimary,
              size: 36,
            )),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        //Till image to for against
        children: [
          //Image
          Container(
            height: 230,
            width: 430,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.imagePath),
                fit: BoxFit.fill,
              ),
            ),
          ),

          SizedBox(height: 10),
          // Statement
          // Text(widget.statement),
          // SizedBox(height: 10),
          Container(
              child: Text(
            widget.statement,
            style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 16),
            textAlign: TextAlign.center,
          )),
          SizedBox(
            height: 10,
          ),
          //Opinion summary stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DebatePageButton(
                title: 'OPINIONS',
                number: 0,
                shouldColor: true,
                imagePath: widget.imagePath,
                statement: widget.statement,
              ),
              //Space
              const SizedBox(
                width: 5,
              ),
              DebatePageButton(
                title: 'SUMMARY',
                imagePath: widget.imagePath,
                number: 1,
                shouldColor: false,
                statement: widget.statement,
              ),
              const SizedBox(
                width: 5,
              ),
              DebatePageButton(
                title: 'STATISTICS',
                imagePath: widget.imagePath,
                number: 2,
                shouldColor: false,
                statement: widget.statement,
              ),
            ],
          ),
          const SizedBox(height: 10),
          //FOR OR AGAINST BUTTONS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // ForOrAgainstButton(
              //   type: true,
              // ),
              //For or against stuff
              Expanded(
                child: ChoiceChip(
                  side: BorderSide(
        color: Colors.black, // Custom border color
        width: 0, // Border width
      ),
                  avatar: null,
                  showCheckmark: false,
                  labelStyle: TextStyle(color: Colors.white),
                  labelPadding: EdgeInsets.all(8),
                  backgroundColor: Color.fromRGBO(68, 161, 160, 0.4),
                  selectedColor: Color.fromRGBO(68, 161, 160, 1),
                  label: Container(
                    height: 50,
                    child: Center(
                        child: Text(
                      "FOR",
                      style: TextStyle(fontSize: 20),
                    )),
                  ),
                  selected: _isSelectedFor,
                  onSelected: (isSelectedFor) {
                    setState(() {
                      _isSelectedFor = isSelectedFor;
                      if (isSelectedFor) {
                        _isSelectedAgainst = false;
                      }
                    });
                  },
                ),
              ),
              Expanded(
                child: ChoiceChip(
                   side: BorderSide(
        color: Colors.black, // Custom border color
        width: 0, // Border width
      ),
                  avatar: null,
                  showCheckmark: false,
                  labelStyle: TextStyle(color: Colors.white),
                  
                  labelPadding: EdgeInsets.all(8),
                  backgroundColor: Color.fromRGBO(212, 77, 92, 0.4),
                  selectedColor: Color.fromRGBO(212, 77, 92, 1),
                  label: Container(
                    height: 50,
                    child: Center(
                      child: Text("AGAINST", style: TextStyle(fontSize: 20)),
                    ),
                  ),
                  selected: _isSelectedAgainst,
                  onSelected: (isSelectedAgainst) {
                    setState(() {
                      _isSelectedAgainst = isSelectedAgainst;
                      if (isSelectedAgainst) {
                        _isSelectedFor = false;
                      }
                    });
                  },
                ),
              ),
            ],
          ),
          // Padding(
          //     padding: const EdgeInsets.all(8),
          //     child: Container(
          //         decoration: BoxDecoration(
          //             color: Colors.red,
          //             borderRadius: BorderRadius.circular(2)),
          //         child: Text(
          //           widget.statement,
          //           style: TextStyle(color: Colors.white, fontSize: 16),
          //         ))),
          //sort
          Row(
            children: [
              const SizedBox(
                width: 13,
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.sort,
                    color: Colors.red,
                    size: 30,
                  )),
              GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Sort',
                    style: TextStyle(color: Colors.red, fontSize: 22),
                  ))
            ],
          ),
          const Divider(
            color: Colors.red,
            indent: 20,
            endIndent: 20,
          ),
          // Comments
          Expanded(
            child: ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  return CommentTile(
                    comment: comments[index][0],
                    opinion: comments[index][1],
                    likes: [],
                  );
                }),
          )
        ],
      ),
    );
  }
}
