import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/cubit/movie_detail_cubit.dart';

class MovieDetailScreen extends StatefulWidget {
  final String imdbId;
  const MovieDetailScreen({required this.imdbId});
  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MovieDetailCubit>().getMovieDetail(widget.imdbId);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<MovieDetailCubit, MovieDetailState>(
      builder: (context, state) {
        if (state is MovieDetailLoading) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is MovieDetailFailure) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text('Şu an verilere ulaşılamıyor'),
            ),
          );
        } else if (state is MovieDetailLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: Text(state.movieDetail.title!),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                          width: size.width,
                          height: 350,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Image.network(
                            state.movieDetail.poster!,
                            fit: BoxFit.cover,
                          )),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "${state.movieDetail.title}",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        movieInfo(
                            'Gösterim tarihi', state.movieDetail.released),
                        movieInfo('Yönetmen', state.movieDetail.director),
                        movieInfo('Kategoriler', state.movieDetail.genre),
                        movieInfo('Yazarlar', state.movieDetail.writer),
                        movieInfo('Ülke', state.movieDetail.country),
                        movieInfo('IMDB Skoru', state.movieDetail.imdbRating),
                        Center(
                          child: Text(
                            'Özet',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${state.movieDetail.plot}',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}

Widget movieInfo(String title, String? info) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Text(
          title + ':',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          width: 7,
        ),
        Expanded(
          child: Text(
            info ?? '',
            maxLines: 3,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    ),
  );
}
