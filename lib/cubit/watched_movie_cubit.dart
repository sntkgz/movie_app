import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_app/cubit/base_cubit.dart';
import 'package:my_app/models/movie.dart';

part 'watched_movie_state.dart';

class WatchedMovieCubit extends Cubit<WatchedMovieState> with BaseCubit {
  WatchedMovieCubit() : super(WatchedMovieLoading());

  Future<void> fetchWatchedMovies() async {
    emit(WatchedMovieLoading());
    final watchedMovies = await cloudFirestoreRepository.getWatchedMovies();
    if (watchedMovies.isEmpty) {
      emit(WatchedMovieIsEmptyLoaded(watchedMovies));
    } else {
      emit(WatchedMovieLoaded(watchedMovies));
    }
  }

  Future<void> initialFetchWatchedMovies() async {
    if (state is WatchedMovieLoading) {
      final watchedMovies = await cloudFirestoreRepository.getWatchedMovies();
      if (watchedMovies.isEmpty) {
        emit(WatchedMovieIsEmptyLoaded(watchedMovies));
      } else {
        emit(WatchedMovieLoaded(watchedMovies));
      }
    }
  }
}
