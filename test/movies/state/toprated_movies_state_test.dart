import 'package:filmfan/screens/home/bloc/top_rated_movies/topratedmovie_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("topRatedMoviesState", () {
    test('supports value comparison', () {
      expect(const TopRatedMovieState(), const TopRatedMovieState());
    });
  });
}
