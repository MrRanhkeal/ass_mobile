import 'package:flutter/cupertino.dart';
import 'package:flutter_coffee/app/routes.dart';
import 'package:flutter_coffee/data/remote/models/request/Register_request.dart';
import 'package:flutter_coffee/data/remote/repositories/impl/auth_repository_impl.dart';
import 'package:get/get.dart';

class RegisterViewModel extends GetxController {
  final authRepository = AuthRepositoryImpl();
  var isRegisterLoading = false.obs;
  var nameController = TextEditingController().obs;
  var usernameController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var confirmPasswordController = TextEditingController().obs;
  var registerRequest = RegisterRequest().obs;
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  @override
  void onInit() {
    super.onInit();
  }

  onRegister() async {
    if (nameController.value.text.isEmpty) {
      onMessageError("Name is empty");
    } else if (usernameController.value.text.isEmpty) {
      onMessageError("Username is empty");
    } else if (passwordController.value.text.isEmpty) {
      onMessageError("Password is empty");
    } else if (confirmPasswordController.value.text.isEmpty) {
      onMessageError("Confirm Password is empty");
    } else if (confirmPasswordController.value.text !=
        passwordController.value.text) {
      onMessageError("Confirm Password is not match!");
    } else {
      isRegisterLoading(true);
      registerRequest.value.name = nameController.value.text;
      registerRequest.value.username = usernameController.value.text;
      registerRequest.value.password = passwordController.value.text;
      // role_id will use the default value of 2 from the model

      var response = await authRepository.register(registerRequest.value);
      if (response.isSuccess == true) {
        onMessageSuccess("${response.message}");
        // Clear the form
        nameController.value.clear();
        usernameController.value.clear();
        passwordController.value.clear();
        confirmPasswordController.value.clear();

        // Show success message and navigate
        await Future.delayed(
            const Duration(milliseconds: 1500)); // Wait for 1.5 seconds
        Get.offAllNamed('/login');
      } else {
        onMessageError("${response.message}");
      }
      isRegisterLoading(false);
    }
  }

  onMessageError(message) {
    Get.snackbar("Success", message);
  }

  onMessageSuccess(message) {
    Get.snackbar("Error", message);
  }
}
