// ignore_for_file: must_be_immutable, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:opinio/pages/debate_page.dart';
import 'package:opinio/pages/stats_page.dart';
import 'package:opinio/pages/summary_page.dart';

class DebatePageButton extends StatelessWidget {
  final String imagePath;
  final String name;
  final String debateId;
  final String title;
  bool shouldColor;
  int number; //0 is opinions 1 is summary and 2 is stats
  DebatePageButton({
    super.key,
    required this.shouldColor,
    required this.number,
    required this.imagePath,
    required this.name,
    required this.debateId, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          switch (number) {
            case 0:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DebatePage(
                      imagePath: imagePath,
                      debateId: debateId,
                      title: title,
                    ),
                  ));
              break;
            case 1:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Summarypage(
                            imagePath: imagePath,
                            name: 'SUMMARY',
                            debateId: debateId,
                      title: title,
                          )));
              break;
            case 2:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StatsPage(
                            imagePath: imagePath,
                            name: 'STATISTICS',
                           debateId: debateId,
                      title: title,
                          )));
              break;
            default:
            // Handle invalid number value
          }
        },
        child: Container(
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary),
            ),
          )),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(8),
              border: shouldColor
                  ? Border(bottom: BorderSide(color: Colors.red, width: 1.5))
                  : Border(
                      bottom: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ))),
        ),
      ),
    );
  }
}
