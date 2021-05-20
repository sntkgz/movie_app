
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_app/core/const.dart';
import 'package:my_app/models/movies.dart';
import 'package:my_app/screens/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, title: Text('Filmler')),
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
              itemCount: movieResponse.movies.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3.5,
              ),
              itemBuilder: (context, indeks) {
                var movie = movieResponse.movies[indeks];

                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(movie: movie,)));
                  },
                                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                          '$baseImageUrl/${movie.backdropPath}',
                          fit: BoxFit.cover,
                        ),
                            )),
                        Text(
                          movie.title,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          movie.releaseDate,
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
