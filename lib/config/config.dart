class Config {
  static String apiKey = 'f84f2a15602c25f1afd920edf032f8f7';
  static String baseUrl = 'https://api.themoviedb.org/3';
  static String baseImageUrl = "https://image.tmdb.org/t/p/w500";
  static String baseImageUrlOri = "https://image.tmdb.org/t/p/w500";

  static String guestSessionUrl = "authentication/guest_session/new";
  static String popularUrl = '$baseUrl/movie/popular?api_key=$apiKey&page=1';
  static String genreMovieListUrl =
      '$baseUrl/discover/movie?api_key=$apiKey&language=en-US&sort_by=original_title.asc&include_adult=false&include_video=false&page=1';
  static String topRatedUrl =
      '$baseUrl/movie/top_rated?api_key=$apiKey&language=en-EN&sort_by=original_title.asc&page=1';
  static String searchMovieUrl =
      '$baseUrl/search/movie?api_key=$apiKey&language=en-US&page=1&include_adult=false';
  static String nowPlayingMovieUrl =
      '$baseUrl/movie/now_playing?api_key=$apiKey&language=en-US&sort_by=original_title.asc&page=1';
  static String movieDetailUrl(int movieId) =>
      '$baseUrl/movie/$movieId?api_key=$apiKey&append_to_response=images';
  static String similarMovies(int movieId) =>
      '$baseUrl/movie/$movieId/similar?api_key=$apiKey&language=en-US&page=1';
  static String movieCreditlUrl(int movieId) =>
      '$baseUrl/movie/$movieId/credits?api_key=$apiKey';
}
