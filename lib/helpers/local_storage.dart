import 'dart:async';

import 'package:filmfan/models/movie_model.dart';
import 'package:localstorage/localstorage.dart';

class MovieStore {
  static final LocalStorage storage = LocalStorage('movies.json');

  static FutureOr<List<MovieModel>> getFavoriteMovies() async {
    return storage.ready.then((ready) {
      var favorites = storage.getItem('favorites');
      if (favorites != null) {
        return List<MovieModel>.from(
            favorites.map((x) => MovieModel.fromJson(x)));
      } else {
        return <MovieModel>[];
      }
    });
  }

  static Future<bool> addMovieToFavorites(MovieModel movie) async {
    return storage.ready.then((_) {
      try {
        var favorites = storage.getItem("favorites");
        if (favorites != null) {
          favorites.add(movie.toJson());
          storage.setItem("favorites", favorites);
        } else {
          var favorites = [];
          favorites.add(movie.toJson());
          storage.setItem("favorites", favorites);
        }
        return true;
      } catch (e) {
        return false;
      }
    });
  }

  static Future<bool> removeMovieFromFavorites(MovieModel movie) async {
    return storage.ready.then((_) {
      try {
        var favorites = storage.getItem("favorites");
        if (favorites != null) {
          favorites.removeWhere((element) => element['id'] == movie.id);
          storage.setItem("favorites", favorites);
        }
        return true;
      } catch (_) {
        return false;
      }
    });
  }
}
