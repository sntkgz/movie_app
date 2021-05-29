class ApiException implements Exception {
  final _message;
  final _prefix;

  ApiException([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class FetchDataException extends ApiException {
  FetchDataException(String message)
      : super(message, 'Error During Communication: ');
}

class BadRequestException extends ApiException {
  BadRequestException([message]) : super(message, 'Invalid Request: ');
}

class UnauthorisedException extends ApiException {
  UnauthorisedException([message]) : super(message, 'Unauthorised: ');
}

class InvalidInputException extends ApiException {
  InvalidInputException(String message) : super(message, 'Invalid Input: ');
}

class ConflictException extends ApiException {
  ConflictException(String message)
      : super(message,
            'The request could not be completed due to a conflict with the current state of the target resource: ');
}
