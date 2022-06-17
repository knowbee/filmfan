part of 'popularmovie_cubit.dart';

abstract class PopularMovieState extends Equatable {
  const PopularMovieState();
}

class PopularmovieInitial extends PopularMovieState {
  @override
  List<Object> get props => [];
}

class PopularMovieLoading extends PopularMovieState {
  @override
  List<Object> get props => [];
}

class PopularMovieLoaded extends PopularMovieState {
  final List<MovieModel> popularMovies;

  const PopularMovieLoaded({required this.popularMovies});
  @override
  List<Object> get props => [popularMovies];
}

class PopularMovieFailed extends PopularMovieState {
  @override
  List<Object> get props => [];
}
