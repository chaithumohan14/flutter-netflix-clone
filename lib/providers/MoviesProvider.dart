import 'package:bloc_tuts/models/Movie.dart';
import 'package:flutter/cupertino.dart';

class MoviesProvider extends ChangeNotifier {
  List<Movie> movies = [];

  bool addedOrRemoveInFav(Movie movie) {
    try {
      int indexOfMovie = movies.indexWhere((element) => movie.id == element.id);
      if (indexOfMovie < 0) {
        movies.add(movie);
      }
      movies = movies
          .map((element) => element.id == movie.id
              ? Movie(
                  date: element.date,
                  id: element.id,
                  fav: !element.fav,
                  language: element.language,
                  overview: element.overview,
                  poster: element.poster,
                  rating: element.rating,
                  thumbnail: element.thumbnail,
                  title: element.title,
                )
              : element)
          .toList();
      print(movies);
      notifyListeners();
      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }

  void addNewElement(Movie movie) {
    movies.add(movie);
  }
}
