import 'package:filmfan/models/movie_detail_model.dart';
import 'package:filmfan/repositories/detail_movie_repositories.dart';
import 'package:filmfan/screens/movie_details/bloc/detail_movies/detailmovie_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';

class MockDetailMovieRepository extends Mock implements DetailMovieRepository {}

void main() {
  group("detailMovieCubit", () {
    late DetailMovieRepository detailMovieRepository;
    final movie = MovieDetail();
    setUp(() {
      detailMovieRepository = MockDetailMovieRepository();
      when(() => detailMovieRepository.getDetailMovie(1))
          .thenAnswer((_) async => movie);
    });

    test("initial state is correct", () {
      expect(DetailMovieCubit().state, equals(DetailMovieInitial()));
    });
  });
}
