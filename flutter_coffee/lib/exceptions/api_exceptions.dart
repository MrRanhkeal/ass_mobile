class ApiException implements Exception {
  final String message;
  ApiException(this.message);
  
  @override
  String toString() => message;
}

class BadRequestError extends ApiException {
  BadRequestError(String message) : super(message);
}

class UnAuthorization extends ApiException {
  UnAuthorization(String message) : super(message);
}

class InternalServerError extends ApiException {
  InternalServerError() : super('Internal Server Error');
}

class GeneralError extends ApiException {
  GeneralError(String message) : super(message);
}
