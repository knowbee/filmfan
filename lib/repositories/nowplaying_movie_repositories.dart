import 'package:dio/dio.dart';

import 'package:filmfan/config/config.dart';
import 'package:filmfan/models/movie_model.dart';

class NowPlayingMovieRepository {
  Dio dio = Dio();

  Future<List<MovieModel>> getNowPlayingMovies() async {
    try {
      Response response = await dio.get(Config.nowPlayingMovieUrl);
      final data = response.data['results']
          .map<MovieModel>((json) => MovieModel.fromJson(json))
          .toList();
      return data;
    } catch (e) {
      rethrow;
    }
  }
}
