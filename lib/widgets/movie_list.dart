import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_wish_list/models/movie.dart';
import 'package:movie_wish_list/providers/movies_provider.dart';
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
        )
        : moviesState.movies.isEmpty
        ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'No movies found.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.05
                ),
              )
            ],
          ),
        )
        : ListView.builder(
          key: const ValueKey('movieList'),   // AnimatedSwitcher uses keys to differentiate widgets
          itemCount: moviesState.movies.length,
          itemBuilder: (context, index) {
            Movie movie = moviesState.movies[index];
            return MovieCard(
            title: movie.title,
            rating: movie.rating,
            poster: movie.poster,
            duration: movie.duration,
            categories: movie.genresList,
            description: movie.plot,
          );
          },
        )
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:movie_wish_list/models/movie.dart';
// import 'package:movie_wish_list/notifiers/movies_notifier.dart';
// import 'package:movie_wish_list/widgets/movie_card.dart';

// class MovieList extends ConsumerWidget {
//   const MovieList({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final moviesState = ref.watch(moviesNotifierProvider);

//     return Expanded(
//       child: AnimatedSwitcher(
//         duration: const Duration(milliseconds: 500),
//         child: moviesState.isLoading
//             ? Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const CircularProgressIndicator(),  // Cool loading animation (spinner)
//                     const SizedBox(height: 20),
//                     Text(
//                       'Loading movies...',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: MediaQuery.of(context).size.width * 0.05,
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             : moviesState.movies.isEmpty
//                 ? Center(
//                     child: Text(
//                       'No movies found.',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: MediaQuery.of(context).size.width * 0.05,
//                       ),
//                     ),
//                   )
//                 : ListView.builder(
//                     key: const ValueKey('movieList'),  // AnimatedSwitcher uses keys to differentiate widgets
//                     itemCount: moviesState.movies.length,
//                     itemBuilder: (context, index) {
//                       Movie movie = moviesState.movies[index];
//                       return MovieCard(
//                         title: movie.title,
//                         rating: movie.rating,
//                         poster: movie.poster,
//                         duration: movie.duration,
//                         categories: movie.genresList,
//                         description: movie.plot,
//                       );
//                     },
//                   ),
//       ),
//     );
//   }
// }


// Expanded(
//       child: ListView.builder(
//         itemCount: moviesState.movies.length,
//         itemBuilder: (context, index) {
//           Movie movie = moviesState.movies[index];
//           return MovieCard(
//             title: movie.title,
//             rating: movie.rating,
//             poster: movie.poster,
//             duration: movie.duration,
//             categories: movie.genresList,
//             description: movie.plot,
//           );
//         },
//       ),
//     )