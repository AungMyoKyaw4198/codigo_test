import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_002/ob/movie_ob.dart';
import 'package:test_002/provider/fav_movie_provider.dart';
import 'package:test_002/utils/app_constant.dart';

class DetailScreen extends StatelessWidget {
  final Movie movie;
  const DetailScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            title: const Text(
              'Detail Screen',
            )),
        body: Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  IMAGE_URL + movie.posterPath!,
                  fit: BoxFit.fill,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(movie.title!),
                Consumer<FavMovieProvider>(
                    builder: (context, favMovies, child) {
                  return favMovies.favMovies.contains(movie)
                      ? IconButton(
                          icon: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            Provider.of<FavMovieProvider>(context,
                                    listen: false)
                                .removeFavMovie(movie);
                          },
                        )
                      : IconButton(
                          icon: const Icon(Icons.favorite_outline),
                          onPressed: () {
                            Provider.of<FavMovieProvider>(context,
                                    listen: false)
                                .addFavMovie(movie);
                          },
                        );
                }),
              ],
            ),
            Expanded(child: Text(movie.overview!))
          ],
        ));
  }
}
