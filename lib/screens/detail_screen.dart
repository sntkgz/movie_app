import 'package:flutter/material.dart';
import 'package:my_app/core/const.dart';
import 'package:my_app/models/movies.dart';

class DetailScreen extends StatefulWidget {
  Movie movie;
  DetailScreen({this.movie});
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Image.network(
                        '$baseImageUrl/${widget.movie.backdropPath}')),
                Positioned(
                  top: 0,
                  right: 5,
                  child: SizedBox(
                    height: 50,
                    child: FloatingActionButton(
                      splashColor: Colors.white,
                      backgroundColor: Colors.red,
                      onPressed: () {
                        debugPrint("Favorilere eklendi..");
                      },
                      tooltip: 'Favorilere ekle',
                      child: Icon(Icons.favorite),
                    ),
                  ),
                )
              ],
            ),
            Text("${widget.movie.title}"),
            Text("Gösterim tarihi ${widget.movie.overview}"),
            Text("İzlenme ${widget.movie.popularity}"),
            Text("Özet ${widget.movie.overview}"),
          ],
        ),
      ),
    );
  }
}
