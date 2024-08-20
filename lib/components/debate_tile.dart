import 'package:flutter/material.dart';

class DebateTile extends StatelessWidget {
  final String title;
  final String imagePath;
  DebateTile({super.key, required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/debate_page');
      },
      child: Column(
        children: [
          //Gap between tiles
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            //Container containing image and title
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                // color: Color.fromRGBO(32, 32, 32, 1),
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image container
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      width: 130,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(imagePath),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  // Text Container
                  Expanded(
                    // Wrap Text with Expanded
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(
                          title,
                          style: TextStyle(color: Colors.white),
                          //So that text goes to new line
                          overflow: TextOverflow.visible, 
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
