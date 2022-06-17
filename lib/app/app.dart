import 'package:filmfan/repositories/nowplaying_movie_repositories.dart';
import 'package:filmfan/screens/favorites/bloc/favorites_cubit.dart';
import 'package:filmfan/screens/home/bloc/nowplaying_movies/nowplayingmovie_cubit.dart';
import 'package:filmfan/screens/home/bloc/popular_movies/popularmovie_cubit.dart';
import 'package:filmfan/screens/home/bloc/top_rated_movies/topratedmovie_cubit.dart';
import 'package:filmfan/screens/home/home_page.dart';
import 'package:filmfan/screens/movie_details/bloc/cast_movie/castmovie_cubit.dart';
import 'package:filmfan/screens/movie_details/bloc/detail_movies/detailmovie_cubit.dart';
import 'package:filmfan/screens/movie_details/bloc/similar_movies/similarmovies_cubit.dart';
import 'package:filmfan/screens/search/bloc/search_movie/searchmovie_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PopularMovieCubit()..getPopularMovies(),
        ),
        BlocProvider(
          create: (context) => TopRatedMovieCubit()..getTopRatedMovies(),
        ),
        BlocProvider(
          create: (context) =>
              NowPlayingMovieCubit(repository: NowPlayingMovieRepository())
                ..getNowPlayingMovies(),
        ),
        BlocProvider(
          create: (context) => DetailMovieCubit(),
        ),
        BlocProvider(
          create: (context) => CastMovieCubit(),
        ),
        BlocProvider(
          create: (context) => SearchmovieCubit(),
        ),
        BlocProvider(
          create: (context) => SimilarMoviesCubit(),
        ),
        BlocProvider(
          create: (context) => FavoriteMovieCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}
