import 'dart:math';

class Movie {
  final String thumbnail; //backdrop_path
  final String poster; //poster_path
  final String title; //original_name
  final String language; //original_language
  final String overview; //overview
  final String date; //overview
  final double rating; //vote_average
  final int id;
  final bool fav;

  Movie(
      {this.language,
      this.poster,
      this.thumbnail,
      this.title,
      this.overview,
      this.rating,
      this.date,
      this.id,
      this.fav});

  Movie.fromJson(Map<String, dynamic> json)
      : this.thumbnail = json['backdrop_path'] != null
            ? json['backdrop_path']
            : "https://image.tmdb.org/t/p/original/3kT4KvseaDOz3AbVZv1dIvpxEO3.jpg",
        this.poster = json['poster_path'],
        this.title = json['original_title'] != null
            ? json['original_title']
            : json['original_name'],
        this.language = json['original_language'],
        this.rating = json['vote_average'] + .0,
        this.date = json['release_date'] != null
            ? json['release_date']
            : json['first_air_date'],
        this.id = json['id'] != null ? json['id'] : Random().nextInt(1000),
        this.fav = false,
        this.overview = json['overview'];

  @override
  String toString() {
    return title;
  }
}
