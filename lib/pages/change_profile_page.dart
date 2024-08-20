import 'package:flutter/material.dart';

class ChangeProfilePage extends StatefulWidget {
  const ChangeProfilePage({super.key});

  @override
  State<ChangeProfilePage> createState() => _CHangeProfilePageState();
}

class _CHangeProfilePageState extends State<ChangeProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          "O P I N I O",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          overflow: TextOverflow.visible,
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Text('Change Profile Page',style: TextStyle(color: Colors.white,fontSize: 32),),
    );
  }
}