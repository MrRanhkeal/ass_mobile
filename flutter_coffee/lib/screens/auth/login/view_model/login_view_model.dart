import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_coffee/app/routes.dart';
import 'package:flutter_coffee/data/remote/models/request/Login_request.dart';
import 'package:flutter_coffee/data/remote/repositories/impl/auth_repository_impl.dart';
import 'package:flutter_coffee/exceptions/app_exception.dart';
import 'package:flutter_coffee/utils/message_utils.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginViewModel extends GetxController {
  final authRepository = AuthRepositoryImpl();
  var usernameController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var isLoginLoading = false.obs;
  var isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  onLogin() async {
    if (usernameController.value.text.isEmpty) {
      MessageUtils.onMessageError("Username is empty");
      return;
    } 
    if (passwordController.value.text.isEmpty) {
      MessageUtils.onMessageError("Password is empty");
      return;
    }

    isLoginLoading(true);
    try {
      var loginReq = LoginRequest(
        username: usernameController.value.text.trim(),
        password: passwordController.value.text.trim(),
      );

      if (kDebugMode) {
        print('Attempting login with username: ${loginReq.username}');
      }

      var response = await authRepository.login(loginReq);
      
      if (response.isSuccess()) {
        if (kDebugMode) {
          print('Login successful');
          print('Profile: ${response.profile}');
          print('Permissions: ${response.permission}');
        }

        var storage = GetStorage();
        // Store auth data
        storage.write("ACCESS_TOKEN", response.accessToken);
        storage.write("USER_PROFILE", response.profile);
        storage.write("USER_PERMISSIONS", response.permission);
        
        // Show success message
        MessageUtils.onMessageSuccess(response.message ?? 'Login successful');
        
        // Navigate to home
        Get.offAndToNamed(RouteName.homeView);
      } else {
        // Show error message from backend
        final errorMessage = response.error?.toString() ?? 'Login failed';
        if (kDebugMode) {
          print('Login failed: $errorMessage');
        }
        MessageUtils.onMessageError(errorMessage);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Login error: $e');
      }
      MessageUtils.onMessageError(e.toString());
    } finally {
      isLoginLoading(false);
    }
  }
}
