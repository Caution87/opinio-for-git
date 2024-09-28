import 'package:flutter/material.dart';

class LikeButtonForComments extends StatefulWidget {
  final bool isLiked;
  final void Function()? onTap;
  LikeButtonForComments({super.key, required this.isLiked, required this.onTap});

  @override
  State<LikeButtonForComments> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButtonForComments> {
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
      color: Colors.black,);
      
  }
}
