part of 'detailmovie_cubit.dart';

abstract class DetailMovieState extends Equatable {
  const DetailMovieState();
}

class DetailMovieInitial extends DetailMovieState {
  @override
  List<Object> get props => [];
}

class DetailMovieLoading extends DetailMovieState {
  @override
  List<Object> get props => [];
}

class DetailMovieLoaded extends DetailMovieState {
  final MovieDetail movieDetails;

  const DetailMovieLoaded({required this.movieDetails});

  @override
  List<Object> get props => [movieDetails];
}

class DetailMovieFailed extends DetailMovieState {
  @override
  List<Object> get props => [];
}
