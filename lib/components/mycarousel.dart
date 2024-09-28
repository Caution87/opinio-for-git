import 'package:flutter/material.dart';

class MyCarousel extends StatelessWidget {
  final String carouselTitle;
  final String carouselImangePath;
  const MyCarousel({
    super.key,
    required this.carouselTitle,
    required this.carouselImangePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8, // Fixed width for each item
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(carouselImangePath),
          fit: BoxFit.fill,
        ),
         borderRadius: BorderRadius.circular(12),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            carouselTitle,
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              shadows: [
                Shadow(
                  offset: Offset(2.0, 2.0),
                  blurRadius: 3.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
