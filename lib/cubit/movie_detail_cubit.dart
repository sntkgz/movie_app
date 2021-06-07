import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:my_app/cubit/base_cubit.dart';
import 'package:my_app/cubit/favorite_movie_cubit.dart';
import 'package:my_app/models/movie.dart';
import 'package:my_app/models/movie_detail.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> with BaseCubit {
  MovieDetailCubit(this.favoriteMovieCubit) : super(MovieDetailLoading());

  final FavoriteMovieCubit favoriteMovieCubit;
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
}
