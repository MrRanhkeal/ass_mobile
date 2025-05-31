import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_coffee/app/routes.dart';
import 'package:flutter_coffee/data/remote/api/api.dart';
import 'package:flutter_coffee/data/remote/models/request/Login_request.dart';
import 'package:flutter_coffee/data/remote/models/request/Refresh_token_request.dart';
import 'package:flutter_coffee/data/remote/models/response/Login_response.dart';
import 'package:flutter_coffee/data/remote/services/base_api_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../exceptions/api_exceptions.dart';

class BaseApiServiceImpl implements BaseApiService {
  var storage = GetStorage();
  var header = {"Content-Type": "application/json"};

  @override
  Future apiPost(String path, {requestBody}) async {
    dynamic responseBody;
    final url = Uri.parse(Api.baseUrl + path);
    
    if (kDebugMode) {
      print("Request url $url");
      print("Request Body $requestBody");
    }

    try {
      final response = await http.post(
        url,
        headers: header,
        body: jsonEncode(requestBody),
      ).timeout(const Duration(seconds: 120));

      if (kDebugMode) {
        print("Response Status: ${response.statusCode}");
        print("Response Body: ${response.body}");
      }

      if (response.body.isEmpty) {
        throw GeneralError('Empty response from server');
      }

      try {
        responseBody = jsonDecode(response.body);
      } catch (e) {
        throw GeneralError('Invalid JSON response: ${response.body}');
      }

      if (response.statusCode == 200) {
        // Check for error in response body
        if (responseBody is Map && responseBody.containsKey('error')) {
          final error = responseBody['error'];
          if (error is Map && error.containsKey('message')) {
            throw BadRequestError(error['message']);
          } else {
            throw BadRequestError(error.toString());
          }
        }
        return responseBody;
      } else {
        switch (response.statusCode) {
          case 400:
            throw BadRequestError(responseBody['message'] ?? 'Bad request');
          case 401:
            throw UnAuthorization(responseBody['message'] ?? 'Unauthorized');
          case 500:
            throw InternalServerError();
          default:
            throw GeneralError('Server error: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("API Error: $e");
      }
      if (e is ApiException) {
        rethrow;
      }
      throw GeneralError(e.toString());
    }
  }

  Future<bool> _refreshToken() async {
    var refreshRequest = RefreshTokenRequest();
    var refreshToken = await storage.read("REFRESH_TOKEN");
    refreshRequest.refreshToken = refreshToken;
    var response = await apiPost(Api.refreshTokenPath,
        requestBody: refreshRequest.toJson());
    LoginResponse userLogin = LoginResponse.fromJson(response);
    if (userLogin.accessToken != null) {
      await storage.write("ACCESS_TOKEN", response.accessToken);
      await storage.write("REFRESH_TOKEN", response.refreshToken);
      return true;
    }
    return false;
  }

  @override
  Future apiPostWithToken(String path, {req}) async {
    dynamic responseBody;
    final url = Uri.parse(Api.baseUrl + path);

    if (kDebugMode) {
      print("Request url $url\n");
      print("Request Body $req");
    }

    try {
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer ${storage.read("ACCESS_TOKEN")}",
          "Content-Type": "application/json"
        },
        body: jsonEncode(req),
      ).timeout(const Duration(seconds: 120));

      if (kDebugMode) {
        print("Response Status: ${response.statusCode}");
        print("Response Body: ${response.body}");
      }

      responseBody = jsonDecode(response.body);

      // Handle error response from backend
      if (responseBody is Map && responseBody.containsKey('error')) {
        final error = responseBody['error'];
        final message = error is Map ? error['message']?.toString() : error.toString();
        throw BadRequestError(message ?? 'Bad request');
      }

      switch (response.statusCode) {
        case 200:
          return responseBody;
        case 401:
          if (await _refreshToken()) {
            return _retryApiPost(path, req: req);
          } else {
            Get.offAndToNamed(RouteName.splashView);
            throw UnAuthorization('Session expired');
          }
        case 400:
          throw BadRequestError('Bad request');
        case 500:
          throw InternalServerError();
        default:
          throw GeneralError('Server error: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print("API Error: $e");
      }
      if (e is ApiException) {
        rethrow;
      }
      throw GeneralError(e.toString());
    }
  }

  _retryApiPost(String url, {req}) async {
    dynamic responseBody;
    if (kDebugMode) {
      print("Request url $url\n");
      print("Request Body $req");
    }
    var response = await http.post(
      headers: {
        "Authorization": "Bearer ${storage.read("ACCESS_TOKEN")}",
        "Content-Type": "application/json"
      },
      Uri.parse(url),
      body: jsonEncode(req),
    ).timeout(
      const Duration(seconds: 120),
    );
    switch (response.statusCode) {
      case 200:
        responseBody = jsonDecode(response.body);
        break;
      case 400:
        responseBody = jsonDecode(response.body);
        break;
      case 500:
        throw InternalServerError();
    }
    if (kDebugMode) {
      print("Response Body $responseBody");
    }
    return responseBody;
  }
}
