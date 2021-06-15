part of 'watched_movie_cubit.dart';

abstract class WatchedMovieState extends Equatable {
  const WatchedMovieState();

  @override
  List<Object> get props => [];
}

class WatchedMovieLoading extends WatchedMovieState {
  const WatchedMovieLoading();
}

class WatchedMovieLoaded extends WatchedMovieState {
  final List<Movie> watchedMovies;
  const WatchedMovieLoaded(this.watchedMovies);

  @override
  List<Object> get props => [watchedMovies];
}

class WatchedMovieIsEmptyLoaded extends WatchedMovieState {
  final List<Movie> watchedMovies;
  const WatchedMovieIsEmptyLoaded(this.watchedMovies);

  @override
  List<Object> get props => [watchedMovies];
}

class WatchedMovieFailure extends WatchedMovieState {
  const WatchedMovieFailure();
}
