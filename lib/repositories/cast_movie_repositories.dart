import 'package:dio/dio.dart';

import 'package:filmfan/config/config.dart';
import 'package:filmfan/models/cast_movie_model.dart';

class CastMovieRepository {
  Dio dio = Dio();

  Future<MovieCast> getCastMovie(int movieId) async {
    try {
      Response response = await dio.get(Config.movieCreditlUrl(movieId));
      return MovieCast.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
