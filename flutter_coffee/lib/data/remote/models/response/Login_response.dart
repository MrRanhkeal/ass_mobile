import 'User.dart';

class LoginResponse {
  LoginResponse({
    this.message,
    this.error,
    this.accessToken,
    this.profile,
    this.permission,
  });

  LoginResponse.fromJson(dynamic json) {
    message = json['message'];
    if (json['error'] != null) {
      error = json['error'];
      if (error is Map) {
        error = error['message'] ?? error.toString();
      }
    }
    accessToken = json['access_token'];
    profile = json['profile'];
    permission = json['permission'] != null 
        ? List<String>.from(json['permission'])
        : null;
  }

  String? message;
  dynamic error;
  String? accessToken;
  Map<String, dynamic>? profile;
  List<String>? permission;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (error != null) map['error'] = error;
    map['access_token'] = accessToken;
    map['profile'] = profile;
    map['permission'] = permission;
    return map;
  }

  bool isSuccess() => error == null && accessToken != null;
}