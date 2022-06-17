import 'package:filmfan/models/movie_model.dart';
import 'package:filmfan/repositories/detail_movie_repositories.dart';
import 'package:filmfan/screens/movie_details/bloc/similar_movies/similarmovies_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';

class MockSimilarMovieRepository extends Mock implements DetailMovieRepository {
}

void main() {
  group("similarMoviesCubit", () {
    late DetailMovieRepository similarMovieRepository;
    final movies = [MovieModel()];
    setUp(() {
      similarMovieRepository = MockSimilarMovieRepository();
      when(() => similarMovieRepository.getSimilarMovies(1))
          .thenAnswer((_) async => movies);
    });

    test("initial state is correct", () {
      expect(SimilarMoviesCubit().state, equals(SimilarMoviesInitial()));
    });
  });
}
