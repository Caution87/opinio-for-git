import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final bool isLiked;
  final void Function()? onTap;
  LikeButton({super.key, required this.isLiked, required this.onTap});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
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
      color: Colors.white,);
      
  }
}
