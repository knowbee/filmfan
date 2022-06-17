import 'package:filmfan/screens/home/bloc/popular_movies/popularmovie_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("popularMoviesState", () {
    test('supports value comparison', () {
      expect(const PopularMovieState(), const PopularMovieState());
    });
  });
}
