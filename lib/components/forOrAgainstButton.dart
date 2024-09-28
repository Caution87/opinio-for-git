import 'package:flutter/material.dart';

class ForOrAgainstButton extends StatefulWidget {
  //For is true and against is false
  final bool type;
  ForOrAgainstButton({super.key, required this.type});
  @override
  State<ForOrAgainstButton> createState() => _ForOrAgainstButtonState();
}

class _ForOrAgainstButtonState extends State<ForOrAgainstButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Expanded(
        child: Container(
          height: 75,
          decoration: BoxDecoration(
              color: widget.type == true
                  // ? Color.fromRGBO(33, 158, 188, 1)
                  ?Color.fromRGBO(68,161,160,1)
                  // : Color.fromRGBO(255, 80, 3, 1)
                  :Color.fromRGBO(212,77,92,1)
                  ),
          child: Center(
              child: Text(
            widget.type == true ? 'FOR' : 'AGAINST',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )),
        ),
      ),
    );
    // return ChoiceChip(
    //   label: Text(widget.type == true ? 'FOR' : 'AGAINST',),
    //   selected: selected,
    //   color:  widget.type == true,
    //   )
  }
}
