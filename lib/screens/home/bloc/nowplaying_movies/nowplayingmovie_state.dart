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
  final List<MovieModel> nowPlayingMovies;

  const NowPlayingMovieLoaded({required this.nowPlayingMovies});

  @override
  List<Object> get props => [nowPlayingMovies];
}

class NowPlayingMovieFailed extends NowPlayingMovieState {
  @override
  List<Object> get props => [];
}
