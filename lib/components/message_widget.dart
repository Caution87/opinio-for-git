// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget(
      {super.key, required this.text, required this.isFromUser});
  final String text;
  final bool isFromUser;

  @override
  Widget build(BuildContext context) {
    double screenWidth = 520;
    return Row(
      children: [
        Flexible(
            child: Container(
          constraints: BoxConstraints(
            maxWidth: screenWidth,
          ),
          decoration: BoxDecoration(
            color: isFromUser
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            children: [
              MarkdownBody(data: text),
            ],
          ),
        ))
      ],
    );
  }
}
