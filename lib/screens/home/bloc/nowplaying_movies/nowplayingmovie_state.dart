import 'package:equatable/equatable.dart';
import 'package:filmfan/models/movie_model.dart';

abstract class NowPlayingMovieState extends Equatable {
  const NowPlayingMovieState();
}

class NowPlayingMovieInitial extends NowPlayingMovieState {
  @override
  List<Object> get props => [];
}

class NowPlayingMovieLoading extends NowPlayingMovieState {
  @override
  List<Object> get props => [];
}

class NowPlayingMovieLoaded extends NowPlayingMovieState {
  final List<MovieModel> NowPlayingMovies;

  const NowPlayingMovieLoaded({required this.NowPlayingMovies});

  @override
  List<Object> get props => [NowPlayingMovies];
}

class NowPlayingMovieFailed extends NowPlayingMovieState {
  @override
  List<Object> get props => [];
}
