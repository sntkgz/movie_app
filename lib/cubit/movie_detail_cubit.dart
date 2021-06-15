import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:my_app/cubit/base_cubit.dart';
import 'package:my_app/cubit/favorite_movie_cubit.dart';
import 'package:my_app/cubit/watched_movie_cubit.dart';
import 'package:my_app/models/movie.dart';
import 'package:my_app/models/movie_detail.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> with BaseCubit {
  MovieDetailCubit(this.favoriteMovieCubit, this.watchedMovieCubit)
      : super(MovieDetailLoading());

  final FavoriteMovieCubit favoriteMovieCubit;
  final WatchedMovieCubit watchedMovieCubit;
  static final dio = Dio();
  late MovieDetail movieDetail;
  static final formatter = NumberFormat('0000000');

  Future<void> getMovieDetail(String id) async {
    try {
      var formattedId = int.parse(id);
      final response = await dio.get(
          'https://www.omdbapi.com/?apikey=789d9220&i=tt${formatter.format(formattedId)}');
      movieDetail = MovieDetail.fromJson(response.data);
      emit(MovieDetailLoaded(movieDetail));
    } catch (e) {
      print('getMovieDetailError: $e');
      emit(MovieDetailFailure());
    }
  }

  Future<void> addFavoriteMovie(Movie movie) async {
    await cloudFirestoreRepository.addFavoriteMovie(movie);
    await Fluttertoast.showToast(
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15,
        gravity: ToastGravity.SNACKBAR,
        msg: 'Favorilerinize eklendi');
    await favoriteMovieCubit.fetchFavoriteMovies();
  }

  Future<void> removeFavoriteMovie(Movie movie) async {
    await cloudFirestoreRepository.removeFavoriteMovie(movie);
    await Fluttertoast.showToast(
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 15,
        gravity: ToastGravity.SNACKBAR,
        msg: 'Favorilerinizden çıkarıldı');
    await favoriteMovieCubit.fetchFavoriteMovies();
  }

  Future<void> addWatchedMovie(Movie movie) async {
    await cloudFirestoreRepository.addWatchedMovie(movie);
    await Fluttertoast.showToast(
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15,
        gravity: ToastGravity.SNACKBAR,
        msg: 'İzlenen filmlere eklendi');
    await watchedMovieCubit.fetchWatchedMovies();
  }

  Future<void> removeWatchedMovie(Movie movie) async {
    await cloudFirestoreRepository.removeWatchedMovie(movie);
    await Fluttertoast.showToast(
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 15,
        gravity: ToastGravity.SNACKBAR,
        msg: 'İzlenen filmlerden çıkarıldı');
    await watchedMovieCubit.fetchWatchedMovies();
  }
}
