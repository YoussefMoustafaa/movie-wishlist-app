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

    String searchUrl = 'http://192.168.0.142:8000/movies/fresh?query=$query';
    final searchResponse = await http.get(Uri.parse(searchUrl));

    if (searchResponse.statusCode == 200) {
      
      List searchResults = json.decode(searchResponse.body);

      List<Movie> tempMovies = searchResults.map((json) => Movie.fromJson(json)).toList();

      state = state.copyWith(movies: tempMovies, isLoading: false);
    } else {
      state = state.copyWith(isLoading: false);
    }
  }
}