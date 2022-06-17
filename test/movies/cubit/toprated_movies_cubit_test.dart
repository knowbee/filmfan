import 'package:filmfan/models/movie_model.dart';
import 'package:filmfan/repositories/top_rated_movie_repositories.dart';
import 'package:filmfan/screens/home/bloc/top_rated_movies/topratedmovie_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';

class MockTopRatedMovieRepository extends Mock
    implements TopRatedMovieRepository {}

void main() {
  group("topratedMovieCubit", () {
    late TopRatedMovieRepository topRatedMovieRepository;
    final movies = [MovieModel()];
    setUp(() {
      topRatedMovieRepository = MockTopRatedMovieRepository();
      when(() => topRatedMovieRepository.getTopRatedMovies())
          .thenAnswer((_) async => movies);
    });

    test("initial state is correct", () {
      expect(TopRatedMovieCubit().state, equals(TopRatedMovieInitial()));
    });
  });
}
