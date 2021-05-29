import 'package:flutter/material.dart';

enum AuthResultStatus {
  successful,
  sendEmail,
  emailAlreadyExists,
  wrongPassword,
  invalidEmail,
  userNotFound,
  userDisabled,
  operationNotAllowed,
  tooManyRequests,
  signInFailed,
  undefined,
  cancelledByUserFromFacebook,
  networkError,
  signInCancelled,
  requiresRecentLogin
}

class AuthExceptionHandler {
  static dynamic handleException(e) {
    debugPrint('AuthExceptionHandlerError: $e');
    var status;
    switch (e.code) {
      case 'invalid-email':
        status = AuthResultStatus.invalidEmail;
        break;
      case 'wrong-password':
        status = AuthResultStatus.wrongPassword;
        break;
      case 'user-not-found':
        status = AuthResultStatus.userNotFound;
        break;
      case 'user-disabled':
        status = AuthResultStatus.userDisabled;
        break;
      case 'too-many-requests':
        status = AuthResultStatus.tooManyRequests;
        break;
      case 'operation-not-allowed':
        status = AuthResultStatus.operationNotAllowed;
        break;
      case 'emaıl-already-ın-use':
        status = AuthResultStatus.emailAlreadyExists;
        break;
      case 'sign_in_failed':
        status = AuthResultStatus.signInFailed;
        break;
      case 'network_error':
        status = AuthResultStatus.networkError;
        break;
      case 'sign_in_canceled':
        status = AuthResultStatus.signInCancelled;
        break;
      case 'requires-recent-login':
        status = AuthResultStatus.requiresRecentLogin;
        break;
      default:
        status = AuthResultStatus.undefined;
    }
    return status;
  }

  ///
  /// Accepts AuthExceptionHandler.errorType
  ///
  static String generateExceptionMessage(exceptionCode) {
    String errorMessage;
    switch (exceptionCode) {
      case AuthResultStatus.invalidEmail:
        errorMessage = 'Geçersiz bir e-posta girdiniz.';
        break;
      case AuthResultStatus.wrongPassword:
        errorMessage = 'Yanlış bir şifre girdiniz.';
        break;
      case AuthResultStatus.userNotFound:
        errorMessage = 'Bu e-postaya sahip kullanıcı mevcut değil.';
        break;
      case AuthResultStatus.userDisabled:
        errorMessage = 'Bu e-postaya sahip kullanıcı devre dışı bırakıldı.';
        break;
      case AuthResultStatus.tooManyRequests:
        errorMessage = 'Çok fazla istek. Daha sonra tekrar deneyin.';
        break;
      case AuthResultStatus.operationNotAllowed:
        errorMessage =
            'E-posta ve Parola ile oturum açma etkinleştirilmemiştir.';
        break;
      case AuthResultStatus.emailAlreadyExists:
        errorMessage =
            'Böyle bir e-posta mevcut. Lütfen giriş yapın veya şifrenizi sıfırlayın.';
        break;
      case AuthResultStatus.signInFailed:
        errorMessage =
            'Giriş yapamazsınız. Lütfen daha sonra tekrar deneyiniz.';
        break;
      case AuthResultStatus.cancelledByUserFromFacebook:
        errorMessage =
            'Hesabınız facebook tarafından iptal edildi. Lütfen daha sonra tekrar deneyiniz.';
        break;
      case AuthResultStatus.networkError:
        errorMessage = 'Lütfen internet bağlantınızı kontrol edin.';
        break;
      case AuthResultStatus.signInCancelled:
        errorMessage =
            'Hesabınız google tarafından iptal edildi. Lütfen daha sonra tekrar deneyiniz.';
        break;
      case AuthResultStatus.requiresRecentLogin:
        errorMessage = 'Bu isteği yeniden denemeden önce tekrar giriş yapın';
        break;
      default:
        errorMessage = 'Tanımsız bir hata oluştu.';
    }

    return errorMessage;
  }
}
