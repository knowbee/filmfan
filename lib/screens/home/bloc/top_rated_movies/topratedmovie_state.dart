part of 'topratedmovie_cubit.dart';

abstract class TopRatedMovieState extends Equatable {
  const TopRatedMovieState();
}

class TopRatedMovieInitial extends TopRatedMovieState {
  @override
  List<Object> get props => [];
}

class TopRatedMovieLoading extends TopRatedMovieState {
  @override
  List<Object> get props => [];
}

class TopRatedMovieLoaded extends TopRatedMovieState {
  final List<MovieModel> topRatedMovies;

  const TopRatedMovieLoaded({required this.topRatedMovies});

  @override
  List<Object> get props => [topRatedMovies];
}

class TopRatedMovieFailed extends TopRatedMovieState {
  @override
  List<Object> get props => [];
}
