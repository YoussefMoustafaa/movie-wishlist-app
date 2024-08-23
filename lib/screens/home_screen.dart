import 'package:flutter/material.dart';
import 'package:movie_wish_list/widgets/custom_search_bar.dart';

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
          Stack(
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
            ],
          ),
          const CustomSearchBar()
        ],
      ),
    );
  }
}