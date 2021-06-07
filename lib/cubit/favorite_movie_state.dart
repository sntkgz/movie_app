part of 'favorite_movie_cubit.dart';

abstract class FavoriteMovieState extends Equatable {
  const FavoriteMovieState();

  @override
  List<Object> get props => [];
}

class FavoriteMovieLoading extends FavoriteMovieState {
  const FavoriteMovieLoading();
}

class FavoriteMovieLoaded extends FavoriteMovieState {
  final List<Movie> favoriteMovies;
  const FavoriteMovieLoaded(this.favoriteMovies);

  @override
  List<Object> get props => [favoriteMovies];
}

class FavoriteMovieIsEmptyLoaded extends FavoriteMovieState {
  final List<Movie> favoriteMovies;
  const FavoriteMovieIsEmptyLoaded(this.favoriteMovies);

  @override
  List<Object> get props => [favoriteMovies];
}

class FavoriteMovieFailure extends FavoriteMovieState {
  const FavoriteMovieFailure();
}
