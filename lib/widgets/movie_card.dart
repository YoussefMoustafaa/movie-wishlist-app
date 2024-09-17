import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required this.title,
    required this.rating,
    required this.poster,
    required this.duration,
    required this.categories,
    required this.description
  });

  final String title;
  final String rating;
  final String poster;
  final String duration;
  final List<String> categories;
  final String description;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    List<String> genresList = categories.length >= 2 ? categories.sublist(0, 2) : categories.sublist(0, categories.length);
    String genres = genresList.join(', ');

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
          Image.network(
            poster,
            height: screenHeight * 0.22,
            errorBuilder: (context, error, stackTrace) {
              // Fallback to image-not-available if the URL fails
              return Image.asset(
                'assets/images/image-not-available.jpeg',
                height: screenHeight * 0.22,
              );
            },
          ),
          SizedBox(width: screenWidth * 0.03,),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row( 
                  mainAxisAlignment: MainAxisAlignment.start,         // first row
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          color: Colors.white
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.015,),
                    const Icon(Icons.star_rounded, color: Colors.amber,),
                    const Text('8.1', style: TextStyle(color: Colors.white),)
                  ],
                ),
                SizedBox(height: screenHeight * 0.008,),
                Row(           // second row
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      duration,
                      style: const TextStyle(color: Colors.white),
                    ),
                    SizedBox(width: screenWidth * 0.018,),
                    Text(
                      genres,
                      style: const TextStyle(color: Colors.white),
                    ),
                    SizedBox(width: screenWidth * 0.018,),
                    Row(
                      children: [
                        const Icon(Icons.add_circle, color:Colors.white),
                        SizedBox(width: screenWidth * 0.005,),
                        const Text('Watchlist', style: TextStyle(color: Colors.white),)
                      ],
                    )
                  ],
                ),
                SizedBox(height: screenHeight * 0.008,),
                Flexible(
                  child: Text(
                    description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: screenWidth * 0.03, color: const Color(0xFFA5A5A5)),
                  ),
                )
              ],
            )
          ),
        ],
      ),
    );
  }
}