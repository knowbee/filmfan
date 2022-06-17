import 'package:filmfan/repositories/cast_movie_repositories.dart';
import 'package:filmfan/screens/movie_details/bloc/cast_movie/castmovie_cubit.dart';
import 'package:filmfan/screens/movie_details/widgets/movie_cast.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';

class MockCastMoviesRepository extends Mock implements CastMovieRepository {}

void main() {
  group("castMovieCubit", () {
    late CastMovieRepository castMovieRepository;
    final movieCast = MovieCast();
    setUp(() {
      castMovieRepository = MockCastMoviesRepository();
      when(() => castMovieRepository.getCastMovie(1))
          .thenAnswer((_) async => movieCast);
    });
    test("initial state is correct", () {
      expect(CastMovieCubit().state, equals(CastMovieInitial()));
    });
  });
}
