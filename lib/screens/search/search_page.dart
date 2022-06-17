import 'package:filmfan/models/movie_model.dart';
import 'package:filmfan/screens/search/bloc/search_movie/searchmovie_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:filmfan/config/config.dart';
import 'package:filmfan/screens/movie_details/detail_page.dart';

class SearchMoviePage extends StatefulWidget {
  const SearchMoviePage({Key? key}) : super(key: key);

  @override
  State<SearchMoviePage> createState() => _SearchMoviescreenstate();
}

class _SearchMoviescreenstate extends State<SearchMoviePage> {
  final TextEditingController _searchTextController = TextEditingController();
  @override
  void initState() {
    context.read<SearchmovieCubit>().reset();
    super.initState();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  void _onPressClear() {
    _searchTextController.clear();
    context.read<SearchmovieCubit>().reset();
  }

  void _getSearchMovies(String query) {
    context.read<SearchmovieCubit>().getSearchMovie(query);
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
      resizeToAvoidBottomInset: false,
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
        title: _buildSearchField(),
        actions: [
          IconButton(
            onPressed: _onPressClear,
            icon: const Icon(
              Icons.close,
              size: 24,
            ),
          ),
        ],
      ),
      body: BlocBuilder<SearchmovieCubit, SearchmovieState>(
        builder: (context, state) {
          if (state is SearchMovieLoading) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white,
                  ),
                ),
              ),
            );
          } else if (state is SearchMovieLoaded) {
            return _buildSearchList(state);
          } else if (state is SearchmovieInitial) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.fitWidth,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Center(
                    child: Text(
                      'What are you looking for?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text(
                "Search Failed",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildSearchList(SearchMovieLoaded state) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 20,
      ),
      itemBuilder: (context, index) {
        final movie = state.searchMovie[index];
        return GestureDetector(
          onTap: () {
            _onPressMovie(movie);
          },
          child: Container(
            color: Colors.black,
            child: Row(
              children: [
                movie.backdropPath != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          Config.baseImageUrl + movie.backdropPath!,
                          height: 60,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(
                        height: 60,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.not_interested,
                          ),
                        ),
                      ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        movie.releaseDate!.length > 3
                            ? movie.releaseDate!.substring(0, 4)
                            : movie.releaseDate!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 25,
        );
      },
      itemCount: state.searchMovie.length,
    );
  }

  _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        hintText: "Search Movie",
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
      ),
      style: const TextStyle(
        color: Colors.white,
      ),
      onChanged: (query) {
        _getSearchMovies(query);
      },
    );
  }
}
