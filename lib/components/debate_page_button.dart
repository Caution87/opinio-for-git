// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class DebatePageButton extends StatelessWidget {
  final String title;
  bool shouldColor;
  DebatePageButton({super.key, required this.title, required this.shouldColor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        )),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(8),
          border: shouldColor?Border(bottom: BorderSide(color: Colors.red,width: 1.5)):Border(bottom: BorderSide(color: Color.fromRGBO(32, 32, 32, 1)))
          
        ),
      ),
    );
  }
}
