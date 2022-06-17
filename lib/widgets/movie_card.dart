import 'package:filmfan/config/config.dart';
import 'package:filmfan/helpers/local_storage.dart';
import 'package:filmfan/models/movie_model.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatefulWidget {
  final MovieModel movie;
  final bool isFavorite;

  const MovieCard({
    Key? key,
    required this.isFavorite,
    required this.movie,
  }) : super(key: key);

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  bool isSetFavorite = false;

  _addMovieToFavorites(MovieModel movie) async {
    setState(() {
      isSetFavorite = true;
    });
    return await MovieStore.addMovieToFavorites(movie);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7)),
                  child: Stack(
                    fit: StackFit.passthrough,
                    children: [
                      Image.network(
                        Config.baseImageUrl + widget.movie.posterPath!,
                        height: 180,
                        fit: BoxFit.cover,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            color: Colors.yellowAccent,
                            icon: widget.isFavorite || isSetFavorite
                                ? const Icon(Icons.favorite)
                                : const Icon(
                                    Icons.favorite_border,
                                  ),
                            onPressed: () =>
                                _addMovieToFavorites(widget.movie)),
                      )
                    ],
                  ))),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.movie.title!,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
          Row(
            children: [
              Text(
                widget.movie.releaseDate!,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white30,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
              const Spacer(),
              Text(
                "${widget.movie.voteAverage?.toStringAsPrecision(2)}",
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.orangeAccent,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
              const Icon(
                Icons.star_half,
                color: Colors.orangeAccent,
                size: 16,
              ),
            ],
          )
        ],
      ),
    );
  }
}
