import 'package:dio/dio.dart';

import 'package:filmfan/config/config.dart';
import 'package:filmfan/models/movie_model.dart';

class NowPlayingMovieRepository {
  Dio dio = Dio();

  Future<List<MovieModel>> getNowPlayingMovies() async {
    try {
      Response response = await dio.get(Config.nowPlayingMovieUrl);
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
