import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_wish_list/models/movie.dart';
import 'package:movie_wish_list/widgets/movie_card.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {


  List<Movie> movies = [];
  final String apiKey = 'cb35e72a';


  Future<void> fetchMovies(String query) async {
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

      setState(() {
        movies = tempMovies;
      });

    }
  }


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return MovieCard(
                  title: movies[index].title,
                  rating: movies[index].rating,
                  poster: movies[index].poster,
                  duration: movies[index].duration,
                  categories: movies[index].genresList,
                  description: movies[index].plot,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}