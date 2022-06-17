// ignore_for_file: library_private_types_in_public_api

import 'package:filmfan/models/movie_model.dart';
import 'package:filmfan/screens/favorites/bloc/favorites_cubit.dart';
import 'package:filmfan/screens/favorites/bloc/favorites_state.dart';
import 'package:filmfan/screens/movie_details/detail_page.dart';
import 'package:filmfan/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final screenCubit = FavoriteMovieCubit();
  List<MovieModel> favorites = [];

  @override
  void initState() {
    screenCubit.getFavoriteMovies();
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: Colors.black,
      ),
      body: BlocConsumer<FavoriteMovieCubit, FavoriteMovieState>(
        bloc: screenCubit,
        listener: (BuildContext context, FavoriteMovieState state) {
          if (state is FavoriteMovieFailed) {}
        },
        builder: (BuildContext context, state) {
          if (state is FavoriteMovieLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(state) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          mainAxisExtent: 250,
          maxCrossAxisExtent: 150,
          mainAxisSpacing: 10,
          crossAxisSpacing: 18),
      itemBuilder: (context, index) {
        var isFavorite = false;
        state.favoriteMovies.forEach((element) {
          if (element.id == state.favoriteMovies[index].id) {
            isFavorite = true;
          }
        });
        return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.23,
            child: GestureDetector(
              onTap: () {
                _onPressMovie(state.favoriteMovies[index]);
              },
              child: MovieCard(
                  isFavorite: isFavorite, movie: state.favoriteMovies[index]),
            ));
      },
      itemCount: state.favoriteMovies.length,
    );
  }
}
