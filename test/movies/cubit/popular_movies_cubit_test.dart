import 'package:filmfan/models/movie_model.dart';
import 'package:filmfan/repositories/popular_movie_repositories.dart';
import 'package:filmfan/screens/home/bloc/popular_movies/popularmovie_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';

class MockPopularMovieRepository extends Mock
    implements PopularMoviesRepository {}

void main() {
  group("popularMovieCubit", () {
    late PopularMoviesRepository popularMovieRepository;
    final movies = [MovieModel()];
    setUp(() {
      popularMovieRepository = MockPopularMovieRepository();
      when(() => popularMovieRepository.getPopularMovies())
          .thenAnswer((_) async => movies);
    });

    test("initial state is correct", () {
      expect(PopularMovieCubit().state, equals(PopularmovieInitial()));
    });
  });
}
