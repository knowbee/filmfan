import 'package:filmfan/screens/movie_details/bloc/similar_movies/similarmovies_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("similarMoviesState", () {
    test('supports value comparison', () {
      expect(const SimilarMoviesState(), const SimilarMoviesState());
    });
  });
}
