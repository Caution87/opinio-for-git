import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:opinio/components/comment_tile.dart';
import 'package:opinio/components/debate_page_button.dart';
import 'package:opinio/components/forOrAgainstButton.dart';

class DebatePage extends StatefulWidget {
  // final String commentId; //To know which comment
  // final List<String> likes;//To know how many likes
  DebatePage({super.key});

  @override
  State<DebatePage> createState() => _DebatePageState();
}

class _DebatePageState extends State<DebatePage> {
  List images = ['lib/Opinio_Images/Global_Warming.jpg'];
  List<List> comments = [
    //0 is for 1 is against
    ['These are the liked comments by the user. No they are not, they are regular comments.', 0],
    ["These comments don't have an opinion property", 1],
    ['They are grey[800] in dark mode', 0],
    ['They will be another color in light mode. This comment is elaborated in order to check new line. To make the comments of different lenghts or sizes', 1],
    ['The comments will have a different color in light mode',0],
    ['Comments should be renamed to opinions and I believe many things in this app need to be renamed',0],
    ['I also believe we need a Light Mode',1],
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
      backgroundColor: Colors.grey[900],
      body: Column(
        //Till image to for against
        children: [
          //Image
          Container(
            height: 230,
            width: 430,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(images[0]),
                fit: BoxFit.fill,
              ),
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/home1_page');
                    },
                    icon: Icon(
                      Icons.arrow_left,
                      color: Colors.white,
                      size: 36,
                    )),
              ),
            ),
          ),

          SizedBox(height: 10),
          //Opinion summary stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DebatePageButton(
                title: 'OPINIONS',
                shouldColor: true,
              ),
              //Space
              SizedBox(
                width: 5,
              ),
              DebatePageButton(
                title: 'SUMMARY',
                shouldColor: false,
              ),
              SizedBox(
                width: 5,
              ),
              DebatePageButton(
                title: 'STATISTICS',
                shouldColor: false,
              ),
            ],
          ),
          SizedBox(height: 10),
          //FOR OR AGAINST BUTTONS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ForOrAgainstButton(
                type: true,
              ),
              ForOrAgainstButton(
                type: false,
              ),
            ],
          ),
          //sort
          Row(
            children: [
              SizedBox(
                width: 13,
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.sort,
                    color: Colors.red,
                    size: 30,
                  )),
              GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Sort',
                    style: TextStyle(color: Colors.red, fontSize: 22),
                  ))
            ],
          ),
          Divider(
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
