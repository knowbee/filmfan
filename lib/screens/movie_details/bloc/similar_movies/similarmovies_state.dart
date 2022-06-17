part of 'similarmovies_cubit.dart';

abstract class SimilarMoviesState extends Equatable {
  const SimilarMoviesState();
}

class SimilarMoviesInitial extends SimilarMoviesState {
  @override
  List<Object> get props => [];
}

class SimilarMoviesLoading extends SimilarMoviesState {
  @override
  List<Object> get props => [];
}

class SimilarMoviesLoaded extends SimilarMoviesState {
  final List<MovieModel> movieDetails;

  const SimilarMoviesLoaded({required this.movieDetails});

  @override
  List<Object> get props => [movieDetails];
}

class SimilarMoviesFailed extends SimilarMoviesState {
  @override
  List<Object> get props => [];
}
