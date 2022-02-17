import 'package:flutter/cupertino.dart';
import 'package:test_002/ob/movie_ob.dart';

class FavMovieProvider extends ChangeNotifier {
  List<Movie> movieList = [];

  List<Movie> get favMovies => movieList;

  addFavMovie(Movie movie) {
    movieList.add(movie);
    notifyListeners();
  }

  removeFavMovie(Movie movie) {
    movieList.remove(movie);
    notifyListeners();
  }
}
