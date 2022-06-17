import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:filmfan/models/movie_model.dart';
import 'package:filmfan/repositories/top_rated_movie_repositories.dart';

part 'topratedmovie_state.dart';

class TopRatedMovieCubit extends Cubit<TopRatedMovieState> {
  final TopRatedMovieRepository repository = TopRatedMovieRepository();
  TopRatedMovieCubit() : super(TopRatedMovieInitial());

  Future<void> getTopRatedMovies() async {
    try {
      emit(TopRatedMovieLoading());
      final result = await repository.getTopRatedMovies();
      emit(TopRatedMovieLoaded(topRatedMovies: result));
    } catch (e) {
      emit(TopRatedMovieFailed());
    }
  }
}
