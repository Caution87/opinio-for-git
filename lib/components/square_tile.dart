// ignore_for_file: avoid_unnecessary_containers, sort_child_properties_last, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
   SquareTile({super.key,required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(imagePath,
      height: 72,),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16)
      ),
    );
  }
}
