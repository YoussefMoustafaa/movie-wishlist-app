import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_wish_list/models/movie.dart';
import 'package:movie_wish_list/providers/movies_provider.dart';
import 'package:movie_wish_list/screens/movie_details.screen.dart';
import 'package:movie_wish_list/widgets/movie_card.dart';

class MovieList extends ConsumerStatefulWidget {
  const MovieList({super.key});

  @override
  ConsumerState<MovieList> createState() => _MovieListState();
}

class _MovieListState extends ConsumerState<MovieList> {

  
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final moviesState = ref.watch(movieNotifierProvider);

    return Expanded(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: moviesState.isLoading
            ? Center(
                // key: const ValueKey('loading'),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        'Loading movies...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.05,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : moviesState.movies.isEmpty
                ? Center(
                    // key: const ValueKey('empty'),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'No movies found.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.05,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: moviesState.movies.length,
                    itemBuilder: (context, index) {
                      Movie movie = moviesState.movies[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MovieDetailsScreen(movie: movie))
                          );
                        },
                        child: MovieCard(
                          key: ValueKey(movie.id),
                          title: movie.title,
                          rating: movie.rating,
                          poster: movie.poster,
                          duration: movie.duration,
                          categories: movie.genresList,
                          description: movie.description,
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
