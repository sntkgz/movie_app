import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/models/movie.dart';

import '../models/user.dart';

class CloudFirestoreRepository {
  final firestore = FirebaseFirestore.instance;

  Future<void> registerNewUser(Profile profile) async {
    await firestore.collection('users').doc(profile.uid).set(profile.toMap());
  }

  Future<List<Movie>> getAllMovies() async {
    List<Movie> movies = [];
    final movieSnapshot = await firestore.collection('movies').get();
    movieSnapshot.docs.forEach((movie) {
      movies.add(Movie.fromJson(movie.data()));
    });
    return movies;
  }
}
