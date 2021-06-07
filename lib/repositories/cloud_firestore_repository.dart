import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/models/comment.dart';
import 'package:my_app/models/movie.dart';

import '../models/profile.dart';

class CloudFirestoreRepository {
  final firestore = FirebaseFirestore.instance;

  Future<void> registerNewUser(Profile profile) async {
    await firestore.collection('users').doc(profile.uid).set(profile.toMap());
  }

  Future<Profile> getProfile() async {
    final profileSnapshot = await firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    final profileData = profileSnapshot.data();
    return Profile.fromMap(profileData!);
  }

  Future<List<Movie>> getAllMovies() async {
    List<Movie> movies = [];
    final movieSnapshot = await firestore.collection('movies').get();
    movieSnapshot.docs.forEach((movie) {
      movies.add(Movie.fromJson(movie.data()));
    });
    return movies;
  }

  Future<void> addFavoriteMovie(Movie movie) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await firestore
        .collection('favoriteMovies')
        .doc(uid)
        .collection('movies')
        .doc(movie.imdbId)
        .set(movie.toJson());
  }

  Future<void> removeFavoriteMovie(Movie movie) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await firestore
        .collection('favoriteMovies')
        .doc(uid)
        .collection('movies')
        .doc(movie.imdbId)
        .delete();
  }

  Future<List<Movie>> getFavoriteMovies() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    List<Movie> movies = [];
    final movieSnapshot = await firestore
        .collection('favoriteMovies')
        .doc(uid)
        .collection('movies')
        .get();
    if (movieSnapshot.size > 0) {
      movieSnapshot.docs.forEach((movie) {
        movies.add(Movie.fromJson(movie.data()));
      });
    }
    return movies;
  }

  Future<List<Comment>> getComments(String imdbId) async {
    List<Comment> comments = [];
    final commentsSnapshot = await firestore
        .collection('comments')
        .doc(imdbId)
        .collection('comments')
        .get();
    if (commentsSnapshot.size > 0) {
      commentsSnapshot.docs.forEach((movie) {
        comments.add(Comment.fromJson(movie.data()));
      });
    }
    return comments;
  }

  Future<void> addComment(Comment comment, String imdbId) async {
    final profile = await getProfile();
    var docReference = firestore
        .collection('comments')
        .doc(imdbId)
        .collection('comments')
        .doc();
    comment.docId = docReference.id;
    comment.fromName = profile.nickName;
    await docReference.set(comment.toJson());
  }

  Future<void> removeComment(Comment comment, String imdbId) async {
    await firestore
        .collection('comments')
        .doc(imdbId)
        .collection('comments')
        .doc(comment.docId)
        .delete();
  }
}
