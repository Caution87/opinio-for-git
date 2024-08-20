// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final hintText;
  final bool obscureText;

  MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      //This removes 25 from left and right
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(    
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(32, 32, 32, 1))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(16, 245, 245, 1))),
          fillColor: Color.fromRGBO(32, 32, 32, 1),
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade500),
        
        ),
      ),
    );
  }
}
