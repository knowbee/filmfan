import 'package:filmfan/screens/home/bloc/nowplaying_movies/nowplayingmovie_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("NowPlayingState", () {
    test('supports value comparison', () {
      expect(const NowPlayingMovieState(), const NowPlayingMovieState());
    });
  });
}
