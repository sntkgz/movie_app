import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:my_app/models/movie_detail.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetailCubit() : super(MovieDetailLoading());

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
}
