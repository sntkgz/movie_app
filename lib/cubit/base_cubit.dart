import 'package:my_app/core/services/locator.dart';
import 'package:my_app/repositories/cloud_firestore_repository.dart';
import 'package:my_app/repositories/firebase_auth_repository.dart';

abstract class BaseCubit {
  var firebaseAuthRepository = getIt<FirebaseAuthRepository>();
  var cloudFirestoreRepository = getIt<CloudFirestoreRepository>();
}
