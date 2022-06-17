import 'package:dio/dio.dart';

import 'package:filmfan/config/config.dart';
import 'package:filmfan/models/movie_model.dart';

class PopularMoviesRepository {
  Dio dio = Dio();

  Future<List<MovieModel>> getPopularMovies() async {
    try {
      Response response = await dio.get(Config.popularUrl);
      return response.data['results']
          .map<MovieModel>((json) => MovieModel.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
