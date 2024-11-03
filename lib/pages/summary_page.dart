import 'package:flutter/material.dart';
import 'package:opinio/components/debate_page_button.dart';
import 'package:opinio/components/forOrAgainstButton.dart';

class Summarypage extends StatefulWidget {
  final String imagePath;
  final String title;
  final String name;
  final String debateId;
  const Summarypage({super.key, required this.imagePath, required this.title, required this.name, required this.debateId});

  @override
  State<Summarypage> createState() => _SummarypageState();
}

class _SummarypageState extends State<Summarypage> {
    var _isSelectedFor = false;
  var _isSelectedAgainst = false;

  bool isLiked = false;
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
            widget.title,
            style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 16),
            textAlign: TextAlign.center,
          )),

              SizedBox(height: 10),
              //Opinion summary stats
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DebatePageButton(
                    imagePath: widget.imagePath,
                    shouldColor: false,
                    number: 0,
                    name: 'OPINIONS', debateId: widget.debateId,title: widget.title,
                  ),
                  //Space
                  const SizedBox(
                    width: 5,
                  ),
                  DebatePageButton(
                    imagePath: widget.imagePath,
                    shouldColor: true,
                    number: 1, name: 'SUMMARY', debateId: widget.debateId,title: widget.title,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  DebatePageButton(
                    imagePath: widget.imagePath,
                    shouldColor: false,
                    number: 2, name: 'STATISTICS', debateId: widget.debateId,title: widget.title,
                  ),
                ],
              ),
              const SizedBox(height: 10),         
            ]));
  }
}
