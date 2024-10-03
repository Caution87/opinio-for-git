import 'package:flutter/material.dart';
import 'package:opinio/components/debate_page_button.dart';
import 'package:opinio/components/forOrAgainstButton.dart';

class Summarypage extends StatefulWidget {
  final String imagePath;
  final String statement;
  const Summarypage({super.key, required this.imagePath, required this.statement});

  @override
  State<Summarypage> createState() => _SummarypageState();
}

class _SummarypageState extends State<Summarypage> {
  List images = ['lib/Opinio_Images/Global_Warming.jpg'];
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
              //Opinion summary stats
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DebatePageButton(
                    imagePath: widget.imagePath,
                    title: 'OPINIONS',
                    number: 0,
                    shouldColor: false, statement: widget.statement,
                  ),
                  //Space
                  const SizedBox(
                    width: 5,
                  ),
                  DebatePageButton(
                    imagePath: widget.imagePath,
                    statement: widget.statement,
                    title: 'SUMMARY',
                    number: 1,
                    shouldColor: true,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  DebatePageButton(
                    imagePath: widget.imagePath,
                    statement: widget.statement,
                    title: 'STATISTICS',
                    number: 2,
                    shouldColor: false,
                  ),
                ],
              ),
              const SizedBox(height: 10),
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
            ]));
  }
}