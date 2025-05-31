import 'package:flutter_coffee/data/remote/models/request/Login_request.dart';
import 'package:flutter_coffee/data/remote/models/request/Register_request.dart';
import 'package:flutter_coffee/data/remote/models/response/base_body_response.dart';
import 'package:flutter_coffee/data/remote/models/response/Login_response.dart';

abstract class AuthRepository {
  Future<BaseBodyResponse> register(RegisterRequest req);
  Future<LoginResponse> login(LoginRequest req);
}