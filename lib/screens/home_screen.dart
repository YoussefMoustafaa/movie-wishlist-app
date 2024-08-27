import 'package:flutter/material.dart';
import 'package:movie_wish_list/widgets/custom_search_bar.dart';
import 'package:movie_wish_list/widgets/movie_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.25,
            width: screenWidth,
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/image 36.png',
                  opacity: const AlwaysStoppedAnimation(0.2),
                ),
                Positioned(
                  top: screenHeight * 0.08,
                  left: screenWidth * 0.04,
                  child: Text(
                    'Find your film',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.085,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.1,
                  right: screenWidth * 0.04,
                  child: Text(
                    'My Watchlist',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.04
                    ),
                  ),
                ),
                Positioned(
                  bottom: screenHeight * 0.01,
                  left: screenWidth * 0.05,
                  child: const CustomSearchBar()
                )
              ],
            ),
          ),
          const Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  MovieCard(
                    title: 'Blade Runner',
                    rating: 8.1,
                    imagePath: 'assets/images/bladerunner.jpg',
                    duration: 116,
                    categories: ['Drama', 'Mystery', 'Sci-fi'],
                    description: 'A blade runner must pursue and terminate four replicants who stole a ship in space, and have returned to Earth to find their creator.',
                  ),
                  MovieCard(
                    title: 'Blade Runner',
                    rating: 8.1,
                    imagePath: 'assets/images/bladerunner.jpg',
                    duration: 116,
                    categories: ['Drama', 'Mystery', 'Sci-fi'],
                    description: 'A blade runner must pursue and terminate four replicants who stole a ship in space, and have returned to Earth to find their creator.',
                  ),
                  MovieCard(
                    title: 'Blade Runner',
                    rating: 8.1,
                    imagePath: 'assets/images/bladerunner.jpg',
                    duration: 116,
                    categories: ['Drama', 'Mystery', 'Sci-fi'],
                    description: 'A blade runner must pursue and terminate four replicants who stole a ship in space, and have returned to Earth to find their creator.',
                  ),
                  MovieCard(
                    title: 'Blade Runner',
                    rating: 8.1,
                    imagePath: 'assets/images/bladerunner.jpg',
                    duration: 116,
                    categories: ['Drama', 'Mystery', 'Sci-fi'],
                    description: 'A blade runner must pursue and terminate four replicants who stole a ship in space, and have returned to Earth to find their creator.',
                  ),
                  MovieCard(
                    title: 'Blade Runner',
                    rating: 8.1,
                    imagePath: 'assets/images/bladerunner.jpg',
                    duration: 116,
                    categories: ['Drama', 'Mystery', 'Sci-fi'],
                    description: 'A blade runner must pursue and terminate four replicants who stole a ship in space, and have returned to Earth to find their creator.',
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}