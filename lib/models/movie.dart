class Movie {
  final String id;
  final String title;
  final String year;
  final String duration;
  final String releaseDate;
  final String genre;
  final String director;
  final String writer;
  final String actors;
  final String plot;
  final String language;
  final String country;
  final String awards;
  final String poster;
  final String rating;
  final String type;

  late List<String> genresList;

  Movie({
    required this.id, 
    required this.title, 
    required this.year, 
    required this.duration, 
    required this.releaseDate, 
    required this.genre, 
    required this.director, 
    required this.writer, 
    required this.actors, 
    required this.plot, 
    required this.language, 
    required this.country, 
    required this.awards, 
    required this.poster, 
    required this.rating, 
    required this.type,

    List<String>? genresList,
  }) {
    this.genresList = genresList ?? genre.split(', ');
  }
  
}