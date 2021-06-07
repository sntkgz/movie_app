import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

import '../core/helpers/auth_exception.dart';
import '../core/services/shared_prefs.dart';
import '../models/profile.dart';
import 'base_cubit.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> with BaseCubit {
  AuthCubit() : super(AuthUninitialized());

  String _errorMsg = '';
  late bool userLoggedIn;

  Future<void> loginWithEmail(
      {required String email, required String password}) async {
    emit(AuthUnauthenticated(true));
    final authResult = await firebaseAuthRepository.loginWithEmail(
        email: email, password: password);

    if (authResult == AuthResultStatus.successful) {
      emit(AuthUnauthenticated(false));
      emit(AuthAuthenticated());
    } else {
      _errorMsg = AuthExceptionHandler.generateExceptionMessage(authResult);
      emit(AuthLoginError(_errorMsg));
      emit(AuthUnauthenticated(false));
    }
  }

  Future<void> registerWithEmail(
      {required String password, required Profile profile}) async {
    emit(AuthUnauthenticated(true));

    final authResult = await firebaseAuthRepository.registerWithEmail(
        password: password, profile: profile);
    if (authResult == AuthResultStatus.successful) {
      emit(AuthUnauthenticated(false));
      emit(AuthAuthenticated());
    } else {
      _errorMsg = AuthExceptionHandler.generateExceptionMessage(authResult);
      emit(AuthLoginError(_errorMsg));
      emit(AuthUnauthenticated(false));
    }
  }

  Future<void> checkUserLogin() async {
    userLoggedIn = firebaseAuthRepository.checkUserLogin();
    if (userLoggedIn) {
      emit(AuthAuthenticated());
    } else {
      if (sharedPrefs.getOnboarding == null || !sharedPrefs.getOnboarding!) {
        emit(AuthOnboarding());
      } else {
        emit(AuthUnauthenticated(false));
      }
    }
  }

  Future<void> clearLocalStorage() async {
    await HydratedBloc.storage.clear();
    HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: await getApplicationDocumentsDirectory());
  }

  Future<void> signOut() async {
    await firebaseAuthRepository.signOut();
    await clearLocalStorage();
    emit(AuthUnauthenticated(false));
  }

  void onboardingDone() {
    sharedPrefs.onboarding = true;
    emit(AuthUnauthenticated(false));
  }
}
