import 'package:equatable/equatable.dart';
import 'package:filmfan/models/movie_model.dart';

abstract class FavoriteMovieState extends Equatable {
  const FavoriteMovieState();
}

class FavoriteMovieInitial extends FavoriteMovieState {
  @override
  List<Object> get props => [];
}

class FavoriteMovieLoading extends FavoriteMovieState {
  @override
  List<Object> get props => [];
}

class FavoriteMovieLoaded extends FavoriteMovieState {
  final List<MovieModel> FavoriteMovies;

  const FavoriteMovieLoaded({required this.FavoriteMovies});

  @override
  List<Object> get props => [FavoriteMovies];
}

class FavoriteMovieFailed extends FavoriteMovieState {
  @override
  List<Object> get props => [];
}
