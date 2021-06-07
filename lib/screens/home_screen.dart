import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/const.dart';
import 'package:my_app/widgets/movie_image.dart';

import '../cubit/movie_cubit.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String movieOption;
  final searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<MovieCubit>().getMovies();
    movieOption = movieOptions.first;
  }

  void handleClick(String value) {
    switch (value) {
      case 'Hepsi':
        context.read<MovieCubit>().allMovies();
        break;
      case 'Suç':
        context.read<MovieCubit>().getMoviesByOption('Crime');
        break;
      case 'Korku':
        context.read<MovieCubit>().getMoviesByOption('Horror');
        break;
      case 'Romantik':
        context.read<MovieCubit>().getMoviesByOption('Romance');
        break;
      case 'Biyografi':
        context.read<MovieCubit>().getMoviesByOption('Biography');
        break;
      case 'Dram':
        context.read<MovieCubit>().getMoviesByOption('Drama');
        break;
    }
    movieOption = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Filmler'),
        actions: <Widget>[
          StatefulBuilder(
            builder: (context, setState) {
              return PopupMenuButton<String>(
                initialValue: movieOption,
                onSelected: (String value) {
                  setState(() {
                    handleClick(value);
                  });
                },
                itemBuilder: (BuildContext context) {
                  return movieOptions.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<MovieCubit, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieLoaded) {
            return Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  child: TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search_outlined),
                        hintText: 'Search..'),
                    controller: searchController,
                    onChanged: (value) {
                      context
                          .read<MovieCubit>()
                          .searchByTitle(searchController.text);
                    },
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: state.movies.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 3.5,
                    ),
                    itemBuilder: (context, index) {
                      var movie = state.movies[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              '/movie_detail_screen',
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
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
