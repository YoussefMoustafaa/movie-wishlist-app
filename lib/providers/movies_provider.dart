import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_wish_list/models/movie.dart';
import 'package:http/http.dart' as http;


final movieNotifierProvider = StateNotifierProvider<MovieNotifier, MovieState>(
  (ref) {
    return MovieNotifier();
  }
);



class MovieState {
  final List<Movie> movies;
  final bool isLoading;

  MovieState({
    required this.movies,
    required this.isLoading,
  });

  MovieState copyWith({List<Movie>? movies, bool? isLoading}) {
    return MovieState(
      movies: movies ?? this.movies,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}



class MovieNotifier extends StateNotifier<MovieState> {
  MovieNotifier() : super(MovieState(movies: [], isLoading: false));

  final String apiKey = 'cb35e72a';
  Future<void> fetchMovies(String query) async {

    state = state.copyWith(isLoading: true);

    String searchUrl = 'https://www.omdbapi.com/?apikey=$apiKey&s=$query';
    final searchResponse = await http.get(Uri.parse(searchUrl));

    if (searchResponse.statusCode == 200) {
      final searchData = json.decode(searchResponse.body);
      List searchResults = searchData['Search'];

      List<Movie> tempMovies = [];
      for (var movie in searchResults) {
        String moveiId = movie['imdbID'];
        String movieDetailsUrl = 'https://www.omdbapi.com/?apikey=$apiKey&i=$moveiId';
        final movieDetailsResponse = await http.get(Uri.parse(movieDetailsUrl));

        if (movieDetailsResponse.statusCode == 200) {
          final movieDetailsData = json.decode(movieDetailsResponse.body);
          Movie m = Movie(
            id: movieDetailsData['imdbID'],
            title: movieDetailsData['Title'],
            year: movieDetailsData['Year'],
            poster: movieDetailsData['Poster'],
            releaseDate: movieDetailsData['Released'],
            duration: movieDetailsData['Runtime'],
            genre: movieDetailsData['Genre'],
            director: movieDetailsData['Director'],
            writer: movieDetailsData['Writer'],
            actors: movieDetailsData['Actors'],
            plot: movieDetailsData['Plot'],
            language: movieDetailsData['Language'],
            country: movieDetailsData['Country'],
            awards: movieDetailsData['Awards'],
            rating: movieDetailsData['imdbRating'],
            type: movieDetailsData['Type']
          );

          tempMovies.add(m);

        }
      }

      state = state.copyWith(movies: tempMovies, isLoading: false);
    } else {
      state = state.copyWith(isLoading: false);
    }
  }
}