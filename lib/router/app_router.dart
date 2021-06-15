import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/cubit/comment_cubit.dart';
import 'package:my_app/cubit/favorite_movie_cubit.dart';
import 'package:my_app/cubit/movie_detail_cubit.dart';
import 'package:my_app/cubit/note_cubit.dart';
import 'package:my_app/cubit/watched_movie_cubit.dart';
import 'package:my_app/models/movie.dart';
import 'package:my_app/screens/movie_detail_screen.dart';
import 'package:my_app/screens/wacthed_movie_detail_screen.dart';
import 'package:my_app/screens/watched_movies_screen.dart';

import '../screens/splash_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );
      case '/movie_detail_screen':
        return PageRouteBuilder(
          settings: RouteSettings(name: 'Movie Detail Screen'),
          pageBuilder: (context, animation, secondaryAnimation) =>
              MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => MovieDetailCubit(
                      context.read<FavoriteMovieCubit>(),
                      context.read<WatchedMovieCubit>())),
              BlocProvider(create: (context) => CommentCubit())
            ],
            child: MovieDetailScreen(movie: routeSettings.arguments as Movie),
          ),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        );
      case '/watched_movies_screen':
        return PageRouteBuilder(
          settings: RouteSettings(name: 'Watched Movies Screen'),
          pageBuilder: (context, animation, secondaryAnimation) =>
              MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => MovieDetailCubit(
                      context.read<FavoriteMovieCubit>(),
                      context.read<WatchedMovieCubit>())),
            ],
            child: WatchedMoviesScreen(),
          ),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        );
      case '/watched_movie_detail_screen':
        return PageRouteBuilder(
          settings: RouteSettings(name: 'Watched Movie Detail Screen'),
          pageBuilder: (context, animation, secondaryAnimation) =>
              MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => MovieDetailCubit(
                      context.read<FavoriteMovieCubit>(),
                      context.read<WatchedMovieCubit>())),
              BlocProvider(create: (context) => NoteCubit())
            ],
            child: WatchedMovieDetailScreen(
                movie: routeSettings.arguments as Movie),
          ),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        );
      default:
        return null;
    }
  }
}
