import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class CloudFirestoreRepository {
  final firestore = FirebaseFirestore.instance;

  Future<void> registerNewUser(Profile profile) async {
    await firestore.collection('users').doc(profile.uid).set(profile.toMap());
  }

  Future<void> getAllMovies() async {
    final a = await firestore.collection('movies').get();
    print(a);
  }
}
