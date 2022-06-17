import 'package:bloc/bloc.dart';
import 'package:filmfan/repositories/nowplaying_movie_repositories.dart';
import 'package:filmfan/screens/home/bloc/nowplaying_movies/nowplayingmovie_state.dart';

class NowPlayingMovieCubit extends Cubit<NowPlayingMovieState> {
  final NowPlayingMovieRepository repository = NowPlayingMovieRepository();
  NowPlayingMovieCubit() : super(NowPlayingMovieInitial());

  Future<void> getNowPlayingMovies() async {
    try {
      emit(NowPlayingMovieLoading());
      final result = await repository.getNowPlayingMovies();
      emit(NowPlayingMovieLoaded(NowPlayingMovies: result));
    } catch (e) {
      emit(NowPlayingMovieFailed());
    }
  }
}
