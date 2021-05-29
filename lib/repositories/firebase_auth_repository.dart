import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/core/helpers/auth_exception.dart';
import 'package:my_app/core/services/locator.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/repositories/cloud_firestore_repository.dart';

class FirebaseAuthRepository {
  late AuthResultStatus _status;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<AuthResultStatus> registerWithEmail(
      {required String password, required Profile profile}) async {
    try {
      var userCredential = await _auth.createUserWithEmailAndPassword(
          email: profile.email, password: password);
      if (userCredential.user != null) {
        _status = AuthResultStatus.successful;
        await getIt<CloudFirestoreRepository>().registerNewUser(Profile(
            uid: userCredential.user!.uid,
            nickName: profile.nickName,
            email: profile.email));
      } else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  Future<AuthResultStatus> loginWithEmail(
      {required String email, required String password}) async {
    try {
      var userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  bool checkUserLogin() {
    if (_auth.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }
}
