import 'package:dio/dio.dart';

import 'package:filmfan/config/config.dart';
import 'package:filmfan/models/movie_model.dart';

class TopRatedMovieRepository {
  Dio dio = Dio();

  Future<List<MovieModel>> getTopRatedMovies() async {
    try {
      Response response = await dio.get(Config.topRatedUrl);
      return response.data['results']
          .map<MovieModel>((json) => MovieModel.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
