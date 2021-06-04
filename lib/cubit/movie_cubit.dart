import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_app/cubit/base_cubit.dart';
import 'package:my_app/models/movie.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> with BaseCubit {
  MovieCubit() : super(MovieLoading());

  List<Movie> movies = [];

  Future<void> getMovies() async {
    movies = await cloudFirestoreRepository.getAllMovies();
    emit(MovieLoaded(movies));
  }

  void getMoviesByOption(String option) {
    List<Movie> crimeMovies = [];
    movies.forEach((movie) {
      if (movie.genre != null && movie.genre!.contains(option)) {
        crimeMovies.add(movie);
      }
    });
    emit(MovieLoaded(crimeMovies));
  }

  void allMovies() {
    emit(MovieLoaded(movies));
  }

  void searchByTitle(String title) {
    final searchMovies = movies
        .where(
            (movie) => movie.title!.toLowerCase().contains(title.toLowerCase()))
        .toList();
    emit(MovieLoaded(searchMovies));
  }
}
