import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:filmfan/models/movie_model.dart';
import 'package:filmfan/repositories/popular_movie_repositories.dart';

part 'popularmovie_state.dart';

class PopularMovieCubit extends Cubit<PopularMovieState> {
  PopularMoviesRepository repository = PopularMoviesRepository();
  PopularMovieCubit() : super(PopularmovieInitial());

  Future<void> getPopularMovies() async {
    try {
      emit(PopularMovieLoading());
      final result = await repository.getPopularMovies();
      emit(PopularMovieLoaded(popularMovies: result));
    } catch (e) {
      emit(PopularMovieFailed());
    }
  }
}
