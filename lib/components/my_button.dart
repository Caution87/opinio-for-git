// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sort_child_properties_last, must_be_immutable

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  Function()? onTap;
  MyButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Center(
            child: Text(
          "Sign In",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(4),
        ),
        //for text field the padding is horizontal:25 i.e. 50 removed form left and right combined
        width: screenWidth - 50,
        height: 60,
      ),
    );
  }
}
