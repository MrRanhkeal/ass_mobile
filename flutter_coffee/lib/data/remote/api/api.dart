import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Api {
  // static const String baseUrl = 'http://localhost:54569';
  static const String baseUrl = 'http://localhost:8081';
  // static const String baseUrl = 'http://192.168.200.52:8081';
  // Authentication endpoints
  static const String getListPath = '/api/auth/get-list';
  static const String registerPath = '/api/auth/register';
  static const String loginPath = '/api/auth/login';
  static const String profilePath = '/api/auth/profile';
  static const String logoutPath = '/api/auth/logout';
  static const String verifyEmailPath = '/api/auth/verify-email';
  static const String forgotPasswordPath = '/api/auth/forgot-password';
  static const String resetPasswordPath = '/api/auth/reset-password';
  static const String updatePath = '/api/auth/update';
  static const String deletePath = '/api/auth/delete';
  static const String refreshTokenPath = '/api/oauth/refresh';
  
  // Categories endpoint
  static const String getAllCategoriesPath = '/api/category/get-list';
  static const String getAllProductsPath = '/api/product/get-list';
  static const String getAllSuppliersPath = '/api/supplier/get-list';
  static const String createSupplierPath = '/api/supplier/create';
  static const String updateSupplierPath = '/api/supplier/update';
  static const String deleteSupplierPath = '/api/supplier/delete';

  // Authentication methods
  static Future<Map<String, dynamic>> register(Map<String, dynamic> userData) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl + registerPath),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(userData),
      );
      return json.decode(response.body);
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  static Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      if (kDebugMode) {
        print('Attempting login with username: $username');
      }

      final response = await http.post(
        Uri.parse(baseUrl + loginPath),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );

      if (kDebugMode) {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }

      if (response.body.isEmpty) {
        return {
          'error': 'Empty response from server',
          'success': false
        };
      }

      final responseData = json.decode(response.body);
      
      // Check for error response from MySQL backend
      if (responseData.containsKey('error')) {
        final error = responseData['error'];
        final message = error is Map ? error['message']?.toString() : error.toString();
        return {
          'error': message ?? 'Login failed',
          'success': false
        };
      }

      // Successful login will have these fields from MySQL
      if (responseData.containsKey('access_token')) {
        return {
          'success': true,
          'access_token': responseData['access_token'],
          'profile': responseData['profile'],
          'permission': responseData['permission'],
          'message': responseData['message'] ?? 'Login successful'
        };
      }

      return {'error': 'Unexpected response format', 'success': false};
    } catch (e) {
      if (kDebugMode) {
        print('Login error: $e');
      }
      return {
        'error': e.toString(),
        'success': false
      };
    }
  }

  static Future<Map<String, dynamic>> getProfile(String token) async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl + profilePath),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      return json.decode(response.body);
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  static Future<Map<String, dynamic>> logout(String token) async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl + logoutPath),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      return json.decode(response.body);
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  static Future<Map<String, dynamic>> updateProfile(String token, Map<String, dynamic> userData) async {
    try {
      final response = await http.put(
        Uri.parse(baseUrl + updatePath),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(userData),
      );
      return json.decode(response.body);
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  // Token refresh method
  static Future<Map<String, dynamic>> refreshToken(String refreshToken) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl + refreshTokenPath),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'refreshToken': refreshToken,
        }),
      );
      return json.decode(response.body);
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  //Categories method
  static Future<Map<String, dynamic>> getAllCategories(String token) async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl + getAllCategoriesPath),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      return json.decode(response.body);
    } catch (e) {
      return {'error': e.toString()};
    }
  }
}