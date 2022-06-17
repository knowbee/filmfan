import 'package:filmfan/screens/movie_details/bloc/detail_movies/detailmovie_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("detailMoviesState", () {
    test('supports value comparison', () {
      expect(const DetailMovieState(), const DetailMovieState());
    });
  });
}
