import 'package:flutter/foundation.dart';
import 'package:flutter_coffee/data/remote/api/api.dart';
import 'package:flutter_coffee/data/remote/models/request/Login_request.dart';
import 'package:flutter_coffee/data/remote/models/request/Register_request.dart';
import 'package:flutter_coffee/data/remote/models/response/base_body_response.dart';
import 'package:flutter_coffee/data/remote/models/response/Login_response.dart';
import 'package:flutter_coffee/data/remote/repositories/auth_repository.dart';
import 'package:flutter_coffee/data/remote/services/base_api_service.dart';
import 'package:flutter_coffee/data/remote/services/base_api_service_impl.dart';

class AuthRepositoryImpl extends AuthRepository{
  final BaseApiService baseApiService = BaseApiServiceImpl();

  @override
  Future<BaseBodyResponse> register(RegisterRequest req) async {
    var response = await baseApiService.apiPost(Api.registerPath, requestBody: req.toJson());
    BaseBodyResponse baseBodyResponse = BaseBodyResponse.fromJson(response);
    return baseBodyResponse;
  }

  @override
  Future<LoginResponse> login(LoginRequest req) async {
    var response = await baseApiService.apiPost(Api.loginPath, requestBody: req.toJson());
    return LoginResponse.fromJson(response);
  }

}