import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/const.dart';
import 'package:my_app/cubit/watched_movie_cubit.dart';
import 'package:my_app/widgets/movie_image.dart';

class WatchedMoviesScreen extends StatefulWidget {
  const WatchedMoviesScreen({Key? key}) : super(key: key);

  @override
  _WatchedMoviesScreenState createState() => _WatchedMoviesScreenState();
}

class _WatchedMoviesScreenState extends State<WatchedMoviesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('İzlenen Filmler'),
      ),
      body: BlocBuilder<WatchedMovieCubit, WatchedMovieState>(
        builder: (context, state) {
          if (state is WatchedMovieLoading) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7), shape: BoxShape.circle),
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: CircularProgressIndicator(
                color: kBlueColor,
              ),
            );
          } else if (state is WatchedMovieIsEmptyLoaded) {
            return Container(
              margin: const EdgeInsets.only(top: 100),
              child: Text('İzlemiş olduğunuz filmleriniz bulunmamaktadır'),
            );
          } else if (state is WatchedMovieLoaded) {
            return GridView.builder(
              itemCount: state.watchedMovies.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3.5,
              ),
              itemBuilder: (context, index) {
                final movie = state.watchedMovies[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        '/watched_movie_detail_screen',
                        arguments: movie);
                  },
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: movieImage(movie.poster),
                        )),
                        Text(
                          movie.title!,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          movie.genre!,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
