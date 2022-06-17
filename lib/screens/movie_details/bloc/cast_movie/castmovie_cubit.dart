import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:filmfan/models/cast_movie_model.dart';
import 'package:filmfan/repositories/cast_movie_repositories.dart';

part 'castmovie_state.dart';

class CastMovieCubit extends Cubit<CastMovieState> {
  final CastMovieRepository repository = CastMovieRepository();
  CastMovieCubit() : super(CastMovieInitial());

  Future<void> getCastMovies(int movieId) async {
    try {
      emit(CastMovieLoading());
      final result = await repository.getCastMovie(movieId);
      emit(CastMovieLoaded(movieCast: result));
    } catch (e) {
      emit(CastMovieFailed());
    }
  }
}
