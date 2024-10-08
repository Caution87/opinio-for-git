import 'package:flutter/material.dart';

class MyLikeButton extends StatefulWidget {
  final bool isLiked;
  final void Function()? onTap;
  MyLikeButton({super.key, required this.isLiked, required this.onTap});

  @override
  State<MyLikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<MyLikeButton> {
  @override
  Widget build(BuildContext context) {
    // return GestureDetector(
    //   onTap: onTap,
    //   child: Icon(
    //     isLiked ? Icons.favorite : Icons.favorite_border,
    //   ),
    // )
    return IconButton(
      onPressed: widget.onTap,
      icon: Icon(widget.isLiked?Icons.favorite:Icons.favorite_border,),
      color: Theme.of(context).colorScheme.inversePrimary,);
      
  }
}
