import 'package:flutter/material.dart';
import 'package:movie_wish_list/models/movie.dart';

class MovieImageCarousel extends StatefulWidget {

  final List<String> imageUrls;
  final Movie movie;

  const MovieImageCarousel({super.key, required this.imageUrls, required this.movie});

  @override
  State<MovieImageCarousel> createState() => _MovieImageCarouselState();
}

class _MovieImageCarouselState extends State<MovieImageCarousel> {

  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), _autoScroll);
  }

  void _autoScroll() {
    if (!mounted) return;
    final nextPage = (_currentPage + 1) % widget.imageUrls.length;

    _pageController.animateToPage(
      nextPage,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );

    setState(() {
      _currentPage = nextPage;
    });

    Future.delayed(const Duration(seconds: 5), _autoScroll);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;


    return SizedBox(
      height: screenHeight * 0.51,
      child: Stack(
        children: [
          SizedBox(
            height: screenHeight * 0.3,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.imageUrls.length,
              onPageChanged: (index) => setState(() => _currentPage = index),
              itemBuilder: (context, index) {
                return Image.network(
                  widget.imageUrls[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                );
              }
            ),
          ),
      
          // Fade at bottom
          Positioned(
            top: screenHeight * 0.2,
            left: 0,
            right: 0,
            child: Container(
              height: screenHeight * 0.1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                  ],
                ),
              ),
            ),
          ),

          // Fade at top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: screenHeight * 0.07,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                  ],
                ),
              ),
            ),
          ),
      
          // Top Buttons
          Positioned(
            top: screenHeight * 0.02,
            left: screenWidth * 0.02,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white,),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Positioned(
            top: screenHeight * 0.02,
            right: screenWidth * 0.02,
            child: IconButton(
              icon: const Icon(Icons.bookmark_outline, color: Colors.white),
              onPressed: () {
                // Handle favorite action
              },
            ),
          ),
      
          // Poster and Info
          Positioned(
            top: screenHeight * 0.26,
            left: screenWidth * 0.05,
            right: screenWidth * 0.05,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Poster
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.movie.poster,
                    height: screenHeight * 0.25,
                    width: screenWidth * 0.3,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: screenWidth * 0.05),
                // Info Text
                Expanded(
                  child: SizedBox(
                    height: screenHeight * 0.3,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.movie.title,
                            style: TextStyle(
                              fontSize: screenWidth * 0.06,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Row(
                            children: [
                              Text(
                                '${widget.movie.year} • ${widget.movie.duration} mins',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                  color: Colors.white70,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                widget.movie.rating.toString(),
                                style: TextStyle(
                                  fontSize: screenWidth * 0.05,
                                  color: Colors.amber,
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.01),
                              Icon(Icons.star, color: Colors.amber, size: screenWidth * 0.05,),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          (widget.movie.numberOfSeasons != null && widget.movie.type == "Show") ? Text(
                            '${widget.movie.type} • ${widget.movie.numberOfSeasons} Seasons',
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              color: Colors.white70,
                              ),
                            ) :
                            Text(
                              widget.movie.type,
                              style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                color: Colors.white70,
                              ),
                            ),
                          SizedBox(height: screenHeight * 0.02),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}