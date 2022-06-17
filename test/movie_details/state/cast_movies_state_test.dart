import 'package:filmfan/screens/movie_details/bloc/cast_movie/castmovie_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("castMoviesState", () {
    test('supports value comparison', () {
      expect(const CastMovieState(), const CastMovieState());
    });
  });
}
