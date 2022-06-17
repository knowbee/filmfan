import 'package:filmfan/helpers/local_storage.dart';
import 'package:filmfan/screens/favorites/bloc/favorites_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteMovieCubit extends Cubit<FavoriteMovieState> {
  FavoriteMovieCubit() : super(FavoriteMovieInitial());

  Future<void> getFavoriteMovies() async {
    try {
      emit(FavoriteMovieLoading());
      final favorites = await MovieStore.getFavoriteMovies();
      emit(FavoriteMovieLoaded(favoriteMovies: favorites));
    } catch (e) {
      emit(FavoriteMovieFailed());
    }
  }
}
