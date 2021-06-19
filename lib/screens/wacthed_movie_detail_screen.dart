import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_app/cubit/note_cubit.dart';

import '../core/const.dart';
import '../cubit/favorite_movie_cubit.dart';
import '../cubit/movie_detail_cubit.dart';
import '../cubit/watched_movie_cubit.dart';
import '../models/comment.dart';
import '../models/movie.dart';
import '../widgets/movie_image.dart';

class WatchedMovieDetailScreen extends StatefulWidget {
  final Movie movie;
  const WatchedMovieDetailScreen({required this.movie});
  @override
  _WatchedMovieDetailScreenState createState() =>
      _WatchedMovieDetailScreenState();
}

class _WatchedMovieDetailScreenState extends State<WatchedMovieDetailScreen> {
  final commentController = TextEditingController();
  final editCommentController = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<MovieDetailCubit>().getMovieDetail(widget.movie.imdbId!);
    context.read<FavoriteMovieCubit>().initialFetchFavoriteMovies();
    context.read<WatchedMovieCubit>().initialFetchWatchedMovies();
    context.read<NoteCubit>().fetchNotes(widget.movie.imdbId!);
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
                          child: movieDetailImage(state.movieDetail.poster!)),
                      Positioned(
                        top: 0,
                        right: 5,
                        child: SizedBox(
                          height: 50,
                          child: BlocBuilder<FavoriteMovieCubit,
                              FavoriteMovieState>(
                            builder: (context, state) {
                              if (state is FavoriteMovieLoading) {
                                return Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.7),
                                      shape: BoxShape.circle),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: CircularProgressIndicator(
                                    color: kBlueColor,
                                  ),
                                );
                              } else if (state is FavoriteMovieIsEmptyLoaded) {
                                return FloatingActionButton(
                                  splashColor: Colors.white,
                                  backgroundColor: Colors.white,
                                  onPressed: () async {
                                    debugPrint("Favorilere eklendi..");
                                    await context
                                        .read<MovieDetailCubit>()
                                        .addFavoriteMovie(widget.movie);
                                  },
                                  tooltip: 'Favorilere ekle',
                                  child: Icon(
                                    Icons.favorite_border_outlined,
                                    color: Colors.red,
                                  ),
                                );
                              } else if (state is FavoriteMovieLoaded) {
                                if (state.favoriteMovies.any((movie) =>
                                    movie.imdbId == widget.movie.imdbId)) {
                                  return FloatingActionButton(
                                    splashColor: Colors.white,
                                    backgroundColor: Colors.white,
                                    onPressed: () async {
                                      debugPrint("Favorilerden çıkarıldı..");
                                      await context
                                          .read<MovieDetailCubit>()
                                          .removeFavoriteMovie(widget.movie);
                                    },
                                    tooltip: 'Favorilere ekle',
                                    child: Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                                  );
                                } else {
                                  return FloatingActionButton(
                                    splashColor: Colors.white,
                                    backgroundColor: Colors.white,
                                    onPressed: () async {
                                      debugPrint("Favorilere eklendi..");
                                      await context
                                          .read<MovieDetailCubit>()
                                          .addFavoriteMovie(widget.movie);
                                    },
                                    tooltip: 'Favorilere ekle',
                                    child: Icon(
                                      Icons.favorite_border_outlined,
                                      color: Colors.red,
                                    ),
                                  );
                                }
                              }
                              return Container();
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 5,
                        child: SizedBox(
                          height: 50,
                          child:
                              BlocBuilder<WatchedMovieCubit, WatchedMovieState>(
                            builder: (context, state) {
                              if (state is WatchedMovieLoading) {
                                return Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.7),
                                      shape: BoxShape.circle),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: CircularProgressIndicator(
                                    color: kBlueColor,
                                  ),
                                );
                              } else if (state is WatchedMovieIsEmptyLoaded) {
                                return FloatingActionButton(
                                  splashColor: Colors.blue,
                                  backgroundColor: Colors.blue,
                                  onPressed: () async {
                                    debugPrint("İzlenenlere eklendi..");
                                    await context
                                        .read<MovieDetailCubit>()
                                        .addWatchedMovie(widget.movie);
                                  },
                                  tooltip: 'İzlenenlere ekle',
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                );
                              } else if (state is WatchedMovieLoaded) {
                                if (state.watchedMovies.any((movie) =>
                                    movie.imdbId == widget.movie.imdbId)) {
                                  return FloatingActionButton(
                                    splashColor: Colors.green,
                                    backgroundColor: Colors.green,
                                    onPressed: () async {
                                      debugPrint("İzlenenlerden çıkarıldı..");
                                      await context
                                          .read<MovieDetailCubit>()
                                          .removeWatchedMovie(widget.movie);
                                    },
                                    tooltip: 'İzlenenlere ekle',
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    ),
                                  );
                                } else {
                                  return FloatingActionButton(
                                    splashColor: Colors.blue,
                                    backgroundColor: Colors.blue,
                                    onPressed: () async {
                                      debugPrint("İzlenenlere eklendi..");
                                      await context
                                          .read<MovieDetailCubit>()
                                          .addWatchedMovie(widget.movie);
                                    },
                                    tooltip: 'İzlenenlere ekle',
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  );
                                }
                              }
                              return Container();
                            },
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
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Card(
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              focusNode: FocusNode(),
                              controller: commentController,
                              cursorColor: Colors.black,
                              minLines: 2,
                              maxLines: 8,
                              decoration: InputDecoration.collapsed(
                                  hintText: "Not yazınız..."),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: ConstrainedBox(
                            constraints:
                                const BoxConstraints(minWidth: double.infinity),
                            child: TextButton(
                              onPressed: () async {
                                await context.read<NoteCubit>().addNote(
                                    Note(
                                      fromId: FirebaseAuth
                                          .instance.currentUser!.uid,
                                      comment: commentController.text,
                                      dateTime: DateFormat('dd-MM-yyyy')
                                          .format(DateTime.now()),
                                    ),
                                    widget.movie.imdbId!);
                                commentController.clear();
                              },
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.symmetric(vertical: 10)),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.blue)),
                              child: Text(
                                'Kaydet'.toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    letterSpacing: 1.25),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Notlarınız',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BlocBuilder<NoteCubit, NoteState>(
                          builder: (context, state) {
                            if (state is NoteLoading) {
                              return Container(
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.7),
                                    shape: BoxShape.circle),
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                child: CircularProgressIndicator(
                                  color: kBlueColor,
                                ),
                              );
                            } else if (state is NoteLoaded) {
                              return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                reverse: true,
                                shrinkWrap: true,
                                itemCount: state.notes.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final note = state.notes[index];
                                  return Container(
                                    padding: EdgeInsets.symmetric(vertical: 6),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '${note.comment}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    editCommentController.text =
                                                        note.comment!;
                                                    await showDialog(
                                                      context: context,
                                                      builder: (_) {
                                                        return AlertDialog(
                                                          title: Text(
                                                              'Notu Düzenle'),
                                                          content: Container(
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        20),
                                                            height: 300,
                                                            width:
                                                                double.infinity,
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .timer,
                                                                      color: Colors
                                                                          .pink,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 4,
                                                                    ),
                                                                    Text(
                                                                        "${note.dateTime}"),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      TextField(
                                                                    focusNode:
                                                                        FocusNode(),
                                                                    controller:
                                                                        editCommentController,
                                                                    cursorColor:
                                                                        Colors
                                                                            .black,
                                                                    minLines: 2,
                                                                    maxLines: 8,
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    TextButton(
                                                                      child:
                                                                          Text(
                                                                        'Vazgeç',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                      style: ButtonStyle(
                                                                          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                                                                              vertical:
                                                                                  14)),
                                                                          backgroundColor:
                                                                              MaterialStateProperty.all(Colors.blue)),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                    ),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    TextButton(
                                                                      child:
                                                                          Text(
                                                                        'Kaydet',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                      style: ButtonStyle(
                                                                          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(
                                                                              vertical:
                                                                                  14)),
                                                                          backgroundColor:
                                                                              MaterialStateProperty.all(Colors.green)),
                                                                      onPressed:
                                                                          () async {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                        note.comment =
                                                                            editCommentController.text;
                                                                        await context.read<NoteCubit>().updateNote(
                                                                            note,
                                                                            widget.movie.imdbId!);
                                                                      },
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Container(
                                                    child: Icon(
                                                      Icons.edit,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    await showDialog(
                                                      context: context,
                                                      builder: (_) {
                                                        return AlertDialog(
                                                          title:
                                                              Text('Notu Sil'),
                                                          content: Text(
                                                              'Notu silmek istediğinizden emin misiniz ?'),
                                                          actions: [
                                                            TextButton(
                                                              child: Text(
                                                                'Vazgeç',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              style: ButtonStyle(
                                                                  padding: MaterialStateProperty.all(const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          14)),
                                                                  backgroundColor:
                                                                      MaterialStateProperty.all(
                                                                          Colors
                                                                              .green)),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            ),
                                                            TextButton(
                                                              child: Text(
                                                                'Sil',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              style: ButtonStyle(
                                                                  padding: MaterialStateProperty.all(const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          14)),
                                                                  backgroundColor:
                                                                      MaterialStateProperty.all(
                                                                          Colors
                                                                              .red)),
                                                              onPressed:
                                                                  () async {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                await context
                                                                    .read<
                                                                        NoteCubit>()
                                                                    .removeNote(
                                                                        note,
                                                                        widget
                                                                            .movie
                                                                            .imdbId!);
                                                              },
                                                            )
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Container(
                                                    child: Icon(
                                                      Icons.delete_outline,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                            return Container();
                          },
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
