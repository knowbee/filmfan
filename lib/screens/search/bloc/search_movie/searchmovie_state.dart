part of 'searchmovie_cubit.dart';

abstract class SearchmovieState extends Equatable {
  const SearchmovieState();
}

class SearchmovieInitial extends SearchmovieState {
  @override
  List<Object> get props => [];
}

class SearchMovieLoaded extends SearchmovieState {
  final List<MovieModel> searchMovie;

  const SearchMovieLoaded({required this.searchMovie});
  @override
  List<Object> get props => [searchMovie];
}

class SearchMovieLoading extends SearchmovieState {
  @override
  List<Object> get props => [];
}

class SearchMovieFailed extends SearchmovieState {
  @override
  List<Object> get props => [];
}
