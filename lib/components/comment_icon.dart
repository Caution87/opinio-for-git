import 'package:flutter/material.dart';

class CommentIcon extends StatefulWidget {
  final void Function()? onTap;
  const CommentIcon({super.key,required this.onTap});

  @override
  State<CommentIcon> createState() => _CommentIconState();
}

class _CommentIconState extends State<CommentIcon> {
  @override
  Widget build(BuildContext context) {
    return  IconButton(
      onPressed: widget.onTap,
      icon: Icon(Icons.comment),
      color: Theme.of(context).colorScheme.inversePrimary,);
  }
}
