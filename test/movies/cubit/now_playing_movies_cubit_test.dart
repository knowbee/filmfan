import 'package:filmfan/models/movie_model.dart';
import 'package:filmfan/repositories/nowplaying_movie_repositories.dart';
import 'package:filmfan/screens/home/bloc/nowplaying_movies/nowplayingmovie_cubit.dart';
import 'package:filmfan/screens/home/bloc/nowplaying_movies/nowplayingmovie_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';

class MockNowMovieRepository extends Mock implements NowPlayingMovieRepository {
}

void main() {
  group("nowPlayingCubit", () {
    late NowPlayingMovieRepository nowPlayingMovieRepository;
    final movies = [MovieModel()];
    setUp(() {
      nowPlayingMovieRepository = MockNowMovieRepository();
      when(() => nowPlayingMovieRepository.getNowPlayingMovies())
          .thenAnswer((_) async => movies);
    });

    test("initial state is correct", () {
      expect(NowPlayingMovieCubit(repository: nowPlayingMovieRepository).state,
          equals(NowPlayingMovieInitial()));
    });
  });
}
