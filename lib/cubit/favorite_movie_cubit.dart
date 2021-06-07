import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_app/cubit/base_cubit.dart';
import 'package:my_app/models/movie.dart';

part 'favorite_movie_state.dart';

class FavoriteMovieCubit extends Cubit<FavoriteMovieState> with BaseCubit {
  FavoriteMovieCubit() : super(FavoriteMovieLoading());

  Future<void> fetchFavoriteMovies() async {
    emit(FavoriteMovieLoading());
    final favMovies = await cloudFirestoreRepository.getFavoriteMovies();
    if (favMovies.isEmpty) {
      emit(FavoriteMovieIsEmptyLoaded(favMovies));
    } else {
      emit(FavoriteMovieLoaded(favMovies));
    }
  }

  Future<void> initialFetchFavoriteMovies() async {
    if (state is FavoriteMovieLoading) {
      final favMovies = await cloudFirestoreRepository.getFavoriteMovies();
      if (favMovies.isEmpty) {
        emit(FavoriteMovieIsEmptyLoaded(favMovies));
      } else {
        emit(FavoriteMovieLoaded(favMovies));
      }
    }
  }
}
