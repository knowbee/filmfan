import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:filmfan/models/movie_model.dart';
import 'package:filmfan/repositories/detail_movie_repositories.dart';

part 'similarmovies_state.dart';

class SimilarMoviesCubit extends Cubit<SimilarMoviesState> {
  final DetailMovieRepository repository = DetailMovieRepository();
  SimilarMoviesCubit() : super(SimilarMoviesInitial());

  Future<void> getSimilarMovies(int movieId) async {
    try {
      emit(SimilarMoviesLoading());
      final result = await repository.getSimilarMovies(movieId);
      emit(SimilarMoviesLoaded(movieDetails: result));
    } catch (e) {
      emit(SimilarMoviesFailed());
    }
  }
}
