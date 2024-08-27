import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required this.title,
    required this.rating,
    required this.imagePath,
    required this.duration,
    required this.categories,
    required this.description
  });

  final String title;
  final double rating;
  final String imagePath;
  final int duration;
  final List<String> categories;
  final String description;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    String genres = '${categories[0]}, ${categories[1]}';

    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      padding: EdgeInsets.only(
        top: screenHeight * 0.025,
        bottom: screenHeight * 0.025
      ),
      height: screenHeight * 0.22,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF2C2C2C), width: 1.5))
      ),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            height: screenHeight * 0.22,
          ),
          SizedBox(width: screenWidth * 0.03,),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(          // first row
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        color: Colors.white
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.015,),
                    const Icon(Icons.star_rounded, color: Colors.amber,),
                    const Text('8.1', style: TextStyle(color: Colors.white),)
                  ],
                ),
                SizedBox(height: screenHeight * 0.008,),
                Row(      // second row
                  children: [
                    Text(
                      '$duration min',
                      style: const TextStyle(color: Colors.white),
                    ),
                    SizedBox(width: screenWidth * 0.018,),
                    Text(
                      genres,
                      style: const TextStyle(color: Colors.white),
                    ),
                    SizedBox(width: screenWidth * 0.018,),
                    const Icon(Icons.add_circle, color:Colors.white),
                    SizedBox(width: screenWidth * 0.005,),
                    const Text('Watchlist', style: TextStyle(color: Colors.white),)
                  ],
                ),
                SizedBox(height: screenHeight * 0.008,),
                Text(
                  description,
                  style: TextStyle(fontSize: screenWidth * 0.03, color: const Color(0xFFA5A5A5)),
                )
              ],
            )
          ),
        ],
      ),
    );
  }
}