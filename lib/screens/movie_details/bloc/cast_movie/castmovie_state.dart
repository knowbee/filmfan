part of 'castmovie_cubit.dart';

abstract class CastMovieState extends Equatable {
  const CastMovieState();
}

class CastMovieInitial extends CastMovieState {
  @override
  List<Object> get props => [];
}

class CastMovieLoading extends CastMovieState {
  @override
  List<Object> get props => [];
}

class CastMovieLoaded extends CastMovieState {
  final MovieCast movieCast;

  const CastMovieLoaded({required this.movieCast});

  @override
  List<Object> get props => [movieCast];
}

class CastMovieFailed extends CastMovieState {
  @override
  List<Object> get props => [];
}
