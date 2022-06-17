import 'package:bloc/bloc.dart';
import 'package:filmfan/repositories/nowplaying_movie_repositories.dart';
import 'package:filmfan/screens/home/bloc/nowplaying_movies/nowplayingmovie_state.dart';

class NowPlayingMovieCubit extends Cubit<NowPlayingMovieState> {
  NowPlayingMovieCubit({
    required NowPlayingMovieRepository repository,
  }) : super(NowPlayingMovieInitial());
  final NowPlayingMovieRepository repository = NowPlayingMovieRepository();

  Future<void> getNowPlayingMovies() async {
    try {
      emit(NowPlayingMovieLoading());
      final result = await repository.getNowPlayingMovies();
      emit(NowPlayingMovieLoaded(nowPlayingMovies: result));
    } catch (e) {
      emit(NowPlayingMovieFailed());
    }
  }
}
