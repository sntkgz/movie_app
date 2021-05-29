import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/models/user.dart';

class CloudFirestoreRepository {
  final firestore = FirebaseFirestore.instance;

  Future<void> registerNewUser(Profile profile) async {
    await firestore.collection('users').add(profile.toMap());
  }
}
