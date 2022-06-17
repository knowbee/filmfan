import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:filmfan/helpers/local_storage.dart';
import 'package:filmfan/models/movie_model.dart';
import 'package:filmfan/screens/movie_details/bloc/cast_movie/castmovie_cubit.dart';
import 'package:filmfan/screens/movie_details/bloc/detail_movies/detailmovie_cubit.dart';
import 'package:filmfan/screens/movie_details/bloc/similar_movies/similarmovies_cubit.dart';
import 'package:filmfan/screens/movie_details/widgets/movie_cast.dart';
import 'package:filmfan/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:filmfan/config/config.dart';
import 'package:filmfan/helpers/helper.dart';
import 'package:filmfan/models/movie_detail_model.dart';
import 'package:filmfan/screens/search/search_page.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class MovieDetailsPage extends StatefulWidget {
  final MovieModel movie;
  const MovieDetailsPage({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  State<MovieDetailsPage> createState() => _DetailMoviescreenstate();
}

class _DetailMoviescreenstate extends State<MovieDetailsPage> {
  var dio = Dio();
  String sessionId = "";
  List<MovieModel> favorites = [];
  bool isSetFavorite = false;

  @override
  void initState() {
    context.read<DetailMovieCubit>().getDetailMovies(widget.movie.id!);
    context.read<CastMovieCubit>().getCastMovies(widget.movie.id!);
    context.read<SimilarMoviesCubit>().getSimilarMovies(widget.movie.id!);
    getSession();
    getLocalFavorites();
    super.initState();
  }

  FutureOr<List<MovieModel>> getLocalFavorites() async {
    var data = await MovieStore.getFavoriteMovies();
    setState(() {
      favorites = data;
    });
    return data;
  }

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

  getSession() {
    dio
        .get(
            "${Config.baseUrl}/${Config.guestSessionUrl}?api_key=${Config.apiKey}")
        .then((value) {
      setState(() {
        sessionId = value.data["guest_session_id"];
      });
    });
  }

  _addMovieToFavorites(MovieModel movie) async {
    setState(() {
      isSetFavorite = true;
    });
    return await MovieStore.addMovieToFavorites(movie);
  }

  Future rateMovie(rating, id) async {
    try {
      var url =
          "${Config.baseUrl}/movie/${id}/rating?api_key=${Config.apiKey}&guest_session_id=${sessionId}&language=en-US";
      print(url);
      var res = await dio.post(url,
          data: {
            "value": rating * 1,
          },
          options: Options(responseType: ResponseType.json));
      Navigator.of(context).pop();
      if (res.data["status_code"] == 1) {
        showTopSnackBar(
          context,
          CustomSnackBar.info(
            message: "Your voted ${rating} for this movie",
            backgroundColor: Colors.orangeAccent,
          ),
        );
      } else {
        showTopSnackBar(
          context,
          CustomSnackBar.info(
            message: "You already voted for this movie, try again later",
            backgroundColor: Colors.orangeAccent,
          ),
        );
      }
    } catch (e) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "Failed to vote for this movie, try again later",
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
          actions: [
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
        body: SingleChildScrollView(
          child: BlocBuilder<DetailMovieCubit, DetailMovieState>(
            builder: (context, state) {
              if (state is DetailMovieLoading) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    ),
                  ),
                );
              } else if (state is DetailMovieLoaded) {
                MovieDetail detail = state.movieDetails;
                bool isFavorite = false;
                favorites.forEach((element) {
                  if (element.id == detail.id) {
                    isFavorite = true;
                  }
                });
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCarouselImage(detail, context),
                    _buildMovieInfo(detail, rateMovie, isFavorite),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        "Cast",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MovieCast(),
                    const SizedBox(
                      height: 50,
                    ),
                    _buildRecommendeMovies(),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                );
              } else if (state is DetailMovieFailed) {
                return const Center(
                  child: Text(
                    'Failed to show details',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ));
  }

  Widget _buildMovieInfo(
      MovieDetail detail, Function rateMovie, bool isFavorite) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 10.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            detail.title!,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              RatingBar(
                onRatingUpdate: (rating) => {rateMovie(rating, detail.id)},
                itemCount: 5,
                ignoreGestures: false,
                itemSize: 12.0,
                initialRating: detail.voteAverage! / 2,
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
              const SizedBox(
                width: 4,
              ),
              Text(
                '${detail.voteAverage?.toStringAsPrecision(2)}',
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                DateFormat.y().format(detail.releaseDate!),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 1,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Center(
                  child: Text(
                    detail.adult == true ? "R18" : "PG",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 1,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: const Center(
                  child: Text(
                    "HD",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              _addMovieToFavorites(widget.movie);
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: isFavorite || isSetFavorite
                    ? Colors.redAccent
                    : Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isFavorite || isSetFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: isFavorite || isSetFavorite
                        ? Colors.white
                        : Colors.black,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    isFavorite || isSetFavorite
                        ? "Added to favorites"
                        : "Add to favorites",
                    style: TextStyle(
                      color: isFavorite || isSetFavorite
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            detail.overview!,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 16,
              height: 1.5,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text(
                "Genre:  ",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              ...List.generate(
                  detail.genres!.length > 4 ? 4 : detail.genres!.length,
                  (index) {
                return detail.genres!.length > 4
                    ? Text(
                        index < 3
                            ? detail.genres![index].name! + ", "
                            : detail.genres![index].name! + "... ",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      )
                    : Text(
                        detail.genres![index] == detail.genres!.last
                            ? detail.genres![index].name! + ""
                            : detail.genres![index].name! + ", ",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      );
              }),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Duration:  " + Helper.convertHoursMinutes(detail.runtime!),
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendeMovies() {
    return BlocBuilder<SimilarMoviesCubit, SimilarMoviesState>(
      builder: (context, state) {
        if (state is SimilarMoviesLoading) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                ),
                child: Row(
                  children: const [
                    Text(
                      "Recommended Movies",
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
        } else if (state is SimilarMoviesLoaded) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                ),
                child: Row(
                  children: const [
                    Text(
                      "Recommended Movies",
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
              _buildMovieList(state.movieDetails),
            ],
          );
        } else {
          return const Text("Failed to load recommended movies");
        }
      },
    );
  }

  Widget _buildMovieList(List<MovieModel> moviesList) {
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
          return GestureDetector(
              onTap: () {
                _onPressMovie(movie);
              },
              child: MovieCard(
                isFavorite: false,
                movie: movie,
              ));
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 22,
          );
        },
        itemCount: moviesList.sublist(0, 10).length,
      ),
    );
  }

  Widget _buildCarouselImage(MovieDetail detail, BuildContext context) {
    return CarouselSlider(
      items: detail.images!.backdrops!.map((movie) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    Config.baseImageUrlOri + movie.filePath!,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
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
            );
          },
        );
      }).toList(),
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.25,
        viewportFraction: 1,
        enlargeCenterPage: false,
      ),
    );
  }
}
