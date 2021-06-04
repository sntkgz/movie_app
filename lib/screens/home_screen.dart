import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_app/cubits/auth_cubit.dart';

import '../core/const.dart';
import '../models/movies.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<MovieResponse> filmlerGetir() async {
    var movieResponse;
    try {
      var response = await Dio().get(moviesUrl);
      movieResponse = MovieResponse.fromJson(response.data);
      print(response);
    } catch (e) {
      print(e);
    }

    return movieResponse;
  }

  final settings = ['Hepsi', 'Aksiyon', 'Korku', 'Eğlence'];

  Future<void> handleClick(String value) async {
    switch (value) {
      case 'Aksiyon':
        // await context.read<AuthCubit>().getAllMovies();
        break;
      case 'Korku':
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Filmler'),
        actions: <Widget>[
          PopupMenuButton<String>(
            initialValue: settings.first,
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return settings.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: FutureBuilder<MovieResponse>(
        future: filmlerGetir(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            var movieResponse = snapshot.data;

            return GridView.builder(
              itemCount: movieResponse!.movies!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3.5,
              ),
              itemBuilder: (context, indeks) {
                var movie = movieResponse.movies![indeks];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailScreen(
                                  movie: movie!,
                                )));
                  },
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            '$baseImageUrl/${movie!.backdropPath}',
                            fit: BoxFit.cover,
                          ),
                        )),
                        Text(
                          movie.title!,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          movie.releaseDate!,
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
          } else {
            return Center();
          }
        },
      ),
    );
  }
}
