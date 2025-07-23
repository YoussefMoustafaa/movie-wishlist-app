import 'package:flutter/material.dart';
import 'package:movie_wish_list/models/movie.dart';
import 'package:movie_wish_list/widgets/movie_image_carousel.dart';


class MovieDetailsScreen extends StatelessWidget {

  final Movie movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xff121212),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MovieImageCarousel(
              imageUrls: movie.pictures,
              movie: movie,
            ),
            
            // Description Section
            Padding(
              padding: EdgeInsets.all(screenHeight * 0.02 ),
              child: Text(
                movie.description,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.thumb_up_outlined, color: Colors.blueAccent,),
                  SizedBox(width: screenWidth * 0.01,),
                  Text(
                    movie.interactions['likes'].toString(),
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.15,),
                  const Icon(Icons.thumb_down_outlined, color: Colors.blueAccent,),
                  SizedBox(width: screenWidth * 0.01,),
                  Text(
                    movie.interactions['dislikes'].toString(),
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color: Colors.blueAccent,
                    ),
                  )
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}