part of 'auth_cubit.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthUninitialized extends AuthState {
  const AuthUninitialized();
}

class AuthOnboarding extends AuthState {
  const AuthOnboarding();
}

class AuthUnauthenticated extends AuthState {
  final bool isLoading;
  const AuthUnauthenticated(this.isLoading);
}

class AuthAuthenticated extends AuthState {
  const AuthAuthenticated();
}

class AuthLoginError extends AuthState {
  final String errorMessage;
  const AuthLoginError(this.errorMessage);
}