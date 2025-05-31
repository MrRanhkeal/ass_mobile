class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._prefix, this._message]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class NotInternetConnection extends AppException {
  NotInternetConnection([String? message])
      : super(message, "No internet connection");
}

class InternalServerError extends AppException{
  InternalServerError([String? message]) : super(message,"Internal server error");
}

class ConnectionTimeout extends AppException{
  ConnectionTimeout([String? message]): super(message,"Connection to server timeout!");
}

class UnAuthorization extends AppException{
  UnAuthorization([String? message]): super(message, "Username and password incorrect!");
}

class GeneralError extends AppException{
  GeneralError([String? message]):super(message, "General exception");
}