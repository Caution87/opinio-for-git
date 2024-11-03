import 'package:flutter/material.dart';
import 'package:opinio/components/debate_tile.dart';

class LikedDebatesPage extends StatefulWidget {
  final String title;
  final String imagePath;
  LikedDebatesPage({super.key, required this.title, required this.imagePath});

  @override
  State<LikedDebatesPage> createState() => _LikedDebatesPageState();
}

class _LikedDebatesPageState extends State<LikedDebatesPage> {
  List<List<String>> likedDebates = [
    [
      "Global Warming is the major problem to face this century.",
      'lib/Opinio_Images/Global_Warming.jpg'
    ],
    ["Anti-litter laws need to be stricter", 'lib/Opinio_Images/litter.jpg'],
    ["Lewis Hamilton should retire.", 'lib/Opinio_Images/lewis_hamilton.jpg'],
    [
      "CGPA is a determining factor for placements.",
      'lib/Opinio_Images/CGPA.jpg'
    ],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        title: Text(
          "O P I N I O",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          overflow: TextOverflow.visible,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: ListView.builder(
          itemCount: likedDebates.length,
          itemBuilder: (contex, index) {
            return DebateTile(title: widget.title, imagePath: widget.imagePath, likes: 7, debateId: '',);
            //return DebateTile(title: likedDebates[index][0], imagePath: likedDebates[index][1])
          }),
    );
  }
}
