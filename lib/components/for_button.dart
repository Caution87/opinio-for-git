import 'package:flutter/material.dart';

class ForButton extends StatefulWidget {
   ForButton({super.key});
  bool _isSelected = false;
  @override
  State<ForButton> createState() => _ForButtonState();
}

class _ForButtonState extends State<ForButton> {
  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text('FOR'), selected: widget._isSelected ,onSelected: (newBoolValue){
        setState(() {
          widget._isSelected= newBoolValue;
        });
      }, );
  }
}