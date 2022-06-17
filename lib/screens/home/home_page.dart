import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:filmfan/helpers/local_storage.dart';
import 'package:filmfan/screens/favorites/favorites_page.dart';
import 'package:filmfan/screens/home/bloc/nowplaying_movies/nowplayingmovie_cubit.dart';
import 'package:filmfan/screens/home/bloc/popular_movies/popularmovie_cubit.dart';
import 'package:filmfan/screens/home/bloc/top_rated_movies/topratedmovie_cubit.dart';
import 'package:filmfan/screens/home/bloc/nowplaying_movies/nowplayingmovie_state.dart';
import 'package:filmfan/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:filmfan/config/config.dart';
import 'package:filmfan/models/movie_model.dart';
import 'package:filmfan/screens/movie_details/detail_page.dart';
import 'package:filmfan/screens/search/search_page.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _Homescreenstate();
}

class _Homescreenstate extends State<HomePage> {
  int _currentCarousel = 0;
  List<MovieModel> favorites = [];

  void _onPressMovie(MovieModel movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailsPage(
          movie: movie,
        ),
      ),
    );
  }

  FutureOr<List<MovieModel>> getLocalFavorites() async {
    var data = await MovieStore.getFavoriteMovies();
    setState(() {
      favorites = data;
    });
    return data;
  }

  @override
  void initState() {
    super.initState();
    getLocalFavorites();
  }

  Future<void> _onRefresh() async {
    context.read<TopRatedMovieCubit>().getTopRatedMovies();
    context.read<NowPlayingMovieCubit>().getNowPlayingMovies();
    context.read<PopularMovieCubit>().getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leadingWidth: 80,
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 20,
          ),
          child: Image.asset(
            "assets/images/logo.png",
            fit: BoxFit.fitWidth,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritesPage(),
                ),
              );
            },
            icon: const Icon(
              Icons.favorite,
              size: 24,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchMoviePage(),
                ),
              );
            },
            icon: const Icon(
              Icons.search,
              size: 25,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        color: Colors.red,
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<PopularMovieCubit, PopularMovieState>(
                builder: (context, state) {
                  if (state is PopularMovieLoading) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                    );
                  } else if (state is PopularMovieLoaded) {
                    return Stack(
                      children: [
                        _buildCarouselSlider(state.popularMovies),
                        _buildDotIndicator(state.popularMovies)
                      ],
                    );
                  } else {
                    return const Text("Failed fetching popular movies");
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<NowPlayingMovieCubit, NowPlayingMovieState>(
                builder: (context, state) {
                  if (state is NowPlayingMovieLoading) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                          ),
                          child: Row(
                            children: const [
                              Text(
                                "Now Playing",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: Center(
                            child: Transform.scale(
                              scale: 0.7,
                              child: const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (state is NowPlayingMovieLoaded) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                          ),
                          child: Row(
                            children: const [
                              Text(
                                "Now Playing",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        _buildMovieList(state.nowPlayingMovies),
                      ],
                    );
                  } else {
                    return const Text("Failed fetching now playing movies");
                  }
                },
              ),
              const SizedBox(
                height: 50,
              ),
              BlocBuilder<TopRatedMovieCubit, TopRatedMovieState>(
                builder: (context, state) {
                  if (state is TopRatedMovieLoading) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                          ),
                          child: Row(
                            children: const [
                              Text(
                                "Top Rated Movies",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: Center(
                            child: Transform.scale(
                              scale: 0.7,
                              child: const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (state is TopRatedMovieLoaded) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                          ),
                          child: Row(
                            children: const [
                              Text(
                                "Top Rated Movies",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        _buildMovieList(state.topRatedMovies),
                      ],
                    );
                  } else {
                    return const Text("Failed fetching top rated movies");
                  }
                },
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildCarouselSlider(List<MovieModel> popularMovies) {
    return CarouselSlider(
      items: popularMovies.sublist(0, 6).map((movie) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                _onPressMovie(movie);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      Config.baseImageUrl + movie.posterPath!,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                alignment: Alignment.bottomLeft,
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Colors.transparent,
                            Colors.transparent,
                            Colors.black,
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Colors.black,
                            Colors.transparent,
                            Colors.transparent,
                            Colors.transparent,
                            Colors.transparent,
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 60,
                      left: 0,
                      right: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Text(
                              '${movie.title}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              RatingBar(
                                onRatingUpdate: (rating) {},
                                itemCount: 5,
                                ignoreGestures: true,
                                itemSize: 12.0,
                                initialRating: movie.voteAverage! / 2,
                                ratingWidget: RatingWidget(
                                  full: const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  half: const Icon(
                                    Icons.star_half,
                                    color: Colors.white,
                                  ),
                                  empty: const Icon(
                                    Icons.star,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _onPressMovie(movie);
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.play_arrow,
                                        color: Colors.black,
                                        size: 28,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Play",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 80,
                                child: Column(
                                  children: const [
                                    Icon(
                                      Icons.info_outline,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
      options: CarouselOptions(
        autoPlay: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 1600),
        height: MediaQuery.of(context).size.height * 0.6,
        viewportFraction: 1,
        enlargeCenterPage: false,
        onPageChanged: (index, reason) {
          setState(
            () {
              _currentCarousel = index;
            },
          );
        },
      ),
    );
  }

  _buildDotIndicator(List<MovieModel> popularMovies) {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: DotsIndicator(
        dotsCount: popularMovies.sublist(0, 6).length,
        position: _currentCarousel.toDouble(),
        decorator: DotsDecorator(
          spacing: const EdgeInsets.all(3.0),
          size: const Size.square(6.0),
          activeSize: const Size(10.0, 6.0),
          activeColor: Colors.red,
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }

  _buildMovieList(List<MovieModel> moviesList) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.30,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var movie = moviesList[index];
          var isFavorite = false;
          for (var element in favorites) {
            if (element.id == movie.id) {
              isFavorite = true;
            }
          }
          return GestureDetector(
              onTap: () {
                _onPressMovie(movie);
              },
              child: MovieCard(movie: movie, isFavorite: isFavorite));
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 20,
          );
        },
        itemCount: moviesList.sublist(0, 10).length,
      ),
    );
  }
}
