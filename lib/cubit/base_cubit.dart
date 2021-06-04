import '../core/services/locator.dart';
import '../repositories/cloud_firestore_repository.dart';
import '../repositories/firebase_auth_repository.dart';

abstract class BaseCubit {
  var firebaseAuthRepository = getIt<FirebaseAuthRepository>();
  var cloudFirestoreRepository = getIt<CloudFirestoreRepository>();
}
