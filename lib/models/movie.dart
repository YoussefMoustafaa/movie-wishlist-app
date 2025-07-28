import 'package:movie_wish_list/models/platform_link.dart';

class Movie {
  final String id;
  final String title;
  final int year;
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
  final Map<String, int> interactions;
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
    required this.interactions,
  });
  

  factory Movie.fromJson(Map<String, dynamic> json) {
    const genreMap = {
    'crm': 'Crime',
    'drm': 'Drama',
    'ani': 'Animation',
    'act': 'Action',
    'cmy': 'Comedy',
    'rma': 'Romance',
    'trl': 'Thriller',
    'adv': 'Adventure',
    'scf': 'Sci-Fi',
    'hrr': 'Horror',
    'hst': 'History',
    'mys': 'Mystery',
    'doc': 'Documentary',
    'fnt': 'Fantasy',
    'eur': 'European',
    'msc': 'Music',
    'fml': 'Family',
  };
  final genreCodes = List<String>.from(json['genres'] ?? []);
  final fullGenres = genreCodes.map((code) => genreMap[code] ?? code).toList();
    return Movie(
      id: json['id'].toString(),
      title: json['title'],
      year: json['year'],
      duration: json['runtime'].toString(),
      description: json['description'],
      rating: json['rating'].toString(),
      type: json['type'],
      poster: json['poster'],
      interactions: {
        'likes': json['interactions']['likes'] ?? 0,
        'dislikes': json['interactions']['dislikes'] ?? 0,
      },
      numberOfSeasons: json['number_of_seasons'],
      genresList: fullGenres,
      pictures: List<String>.from(json['pictures'] ?? []),
      platformLinks: (json['platform_links'] as List).map((e) => PlatformLink.fromJson(e)).toList(),
    );
  }
}