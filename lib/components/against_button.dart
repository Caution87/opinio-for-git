// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class AgainstButton extends StatefulWidget {
   AgainstButton({super.key});
  bool _isSelected = false;
  @override
  State<AgainstButton> createState() => _AgainstButtonState();

}

class _AgainstButtonState extends State<AgainstButton> {
  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text('AGAINST'), selected: widget._isSelected ,onSelected: (newBoolValue){
        setState(() {
          widget._isSelected= newBoolValue;
        });
      }, );
  }
}