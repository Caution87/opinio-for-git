import 'package:flutter/material.dart';

class MyLikeButton extends StatelessWidget {
  final bool isLiked; // Current like status
  final Future<bool> Function(bool) onTap; // Callback for like toggle
  final double size; // Size of the icon

  const MyLikeButton({
    Key? key,
    required this.isLiked,
    required this.onTap,
    this.size = 24, // Default size
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Handle the async call but do not return a Future
        await onTap(isLiked);
      },
      child: Icon(
        Icons.favorite,
        color: isLiked ? Colors.pink : Colors.grey,
        size: size,
      ),
    );
  }
}
