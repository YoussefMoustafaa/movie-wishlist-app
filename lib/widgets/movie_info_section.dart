import 'package:flutter/material.dart';
import 'package:movie_wish_list/models/movie.dart';


class MovieInfoSection extends StatelessWidget {

  final Movie movie;

  const MovieInfoSection({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.all(screenHeight * 0.02),
      color: Colors.black,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Poster
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              movie.poster,
              height: screenHeight * 0.4,
              width: screenWidth * 0.3,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: screenWidth * 0.05),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: screenWidth * 0.05,),
                    SizedBox(width: screenWidth * 0.01),
                    Text(
                      movie.rating.toString(),
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        color: Colors.amber,
                      ),
                    )
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                
              ],
            ),
          ),
        ],
      )
    );
  }
}