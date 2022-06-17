import 'package:filmfan/config/config.dart';
import 'package:filmfan/screens/movie_details/bloc/cast_movie/castmovie_cubit.dart';
import 'package:filmfan/screens/movie_details/bloc/detail_movies/detailmovie_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieCast extends StatelessWidget {
  const MovieCast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CastMovieCubit, CastMovieState>(
      builder: (context, state) {
        if (state is CastMovieLoaded) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.14,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final cast = state.movieCast.cast![index];
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.11,
                  width: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      cast.profilePath != null
                          ? CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey.withOpacity(0.4),
                              backgroundImage: NetworkImage(
                                Config.baseImageUrl + cast.profilePath!,
                              ),
                            )
                          : CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey.withOpacity(0.4),
                              child: const Center(
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        cast.name!,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        cast.character!,
                        style: const TextStyle(
                          color: Colors.green,
                        ),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 5,
                );
              },
              itemCount: state.movieCast.cast!.length,
            ),
          );
        } else if (state is CastMovieLoading) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white,
                ),
              ),
            ),
          );
        } else if (state is DetailMovieFailed) {
          return const Center(
            child: Text(
              'Failed to fetch Cast',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
