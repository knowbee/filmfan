import 'package:dio/dio.dart';

import 'package:filmfan/config/config.dart';
import 'package:filmfan/models/movie_detail_model.dart';
import 'package:filmfan/models/movie_model.dart';

class DetailMovieRepository {
  Dio dio = Dio();

  Future<MovieDetail> getDetailMovie(int movieId) async {
    try {
      Response response = await dio.get(Config.movieDetailUrl(movieId));
      return MovieDetail.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MovieModel>> getSimilarMovies(int movieId) async {
    try {
      Response response = await dio.get(Config.similarMovies(movieId));
      List<MovieModel> results = response.data['results']
          .map<MovieModel>((json) => MovieModel.fromJson(json))
          .toList();

      results.sort((a, b) {
        return a.title!.toLowerCase().compareTo(b.title!.toLowerCase());
      });
      return results;
    } catch (e) {
      rethrow;
    }
  }
}
