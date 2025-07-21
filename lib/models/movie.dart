import 'dart:convert';

import 'package:movie_wish_list/models/platform_link.dart';

class Movie {
  final String id;
  final String title;
  final String year;
  final String duration;
  final String? genre;
  final String? director;
  final String? writer;
  final String? actors;
  final String description;
  final String? language;
  final String? country;
  final String? awards;
  final String poster;
  final String rating;
  final String type;
  final int? numberOfSeasons;

  final List<String> pictures;
  final List<PlatformLink> platformLinks;
  final List<String> genresList;

  Movie({
    required this.id, 
    required this.title, 
    required this.year, 
    required this.duration,
    this.genre, 
    this.director, 
    this.writer, 
    this.actors, 
    required this.description, 
    this.language, 
    this.country, 
    this.awards, 
    required this.poster, 
    required this.rating, 
    required this.type,
    required this.pictures,
    this.numberOfSeasons,
    required this.platformLinks,
    required this.genresList,
  });
  

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'].toString(),
      title: json['title'],
      year: json['year'].toString(),
      duration: json['runtime'].toString(),
      description: json['description'],
      rating: json['rating'].toString(),
      type: json['type'],
      poster: json['poster'],
      genresList: List<String>.from(json['genres'] ?? []),
      pictures: List<String>.from(json['pictures'] ?? []),
      platformLinks: (json['platform_links'] as List).map((e) => PlatformLink.fromJson(e)).toList(),
    );
  }
}