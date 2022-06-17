import 'package:dio/dio.dart';

import 'package:filmfan/config/config.dart';
import 'package:filmfan/models/movie_model.dart';

class SearchMoviesRepository {
  Dio dio = Dio();

  Future<List<MovieModel>> getSearchMovies(String? query) async {
    try {
      Response response =
          await dio.get('${Config.searchMovieUrl}&query=$query');
      return response.data['results']
          .map<MovieModel>((json) => MovieModel.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
