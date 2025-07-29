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
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.02, left: screenWidth * 0.03, bottom: screenHeight * 0.01),
              child: Text(
                'Genres',
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.02),
              child: buildGenreChip(movie.genresList, context),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.02, left: screenWidth * 0.03, bottom: screenHeight * 0.01),
              child: Text(
                'Where to Watch',
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              child: Wrap(
                children: movie.platformLinks.map((platformLink) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                    child: Row(
                      children: [
                        Container(
                          width: screenWidth * 0.11,
                          height: screenWidth * 0.11,
                          decoration: BoxDecoration(
                            // color: Colors.blueGrey.shade800,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              platformLink.platform.iconUrl ?? '',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                // Fallback to image-not-available if the URL fails
                                return Image.asset(
                                  'assets/images/image-not-available.jpeg',
                                  height: screenHeight * 0.22,
                                );
                              }
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        // Platform Details
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              platformLink.platform.platformName,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              [
                                platformLink.monetizationType,
                                platformLink.streamQuality,
                                platformLink.price != null && platformLink.priceCurrency != null
                                    ? '${platformLink.price} ${platformLink.priceCurrency}'
                                    : null,
                              ].where((e) => e != null).join(' • '),
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: screenWidth * 0.035,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget buildGenreChip(List<String> genres, BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: genres.map((genre) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
          child: Chip(
            labelPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
            label: Text(
              genre,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.blue[900],
          ),
        );
      }).toList(),
    ),
  );
}