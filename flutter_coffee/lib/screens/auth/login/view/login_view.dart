import 'package:flutter/material.dart';
import 'package:flutter_coffee/screens/auth/login/view_model/login_view_model.dart';
import 'package:flutter_coffee/widgets/custom_text_field_widget.dart';
import 'package:flutter_coffee/widgets/title_header_widget.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  final LoginViewModel viewModel;

  LoginView({super.key}) : viewModel = Get.put(LoginViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 32),
                    // Center(
                    //   child: Container(
                    //     padding: const EdgeInsets.all(16),
                    //     decoration: BoxDecoration(
                    //       color: Colors.indigo.withOpacity(0.1),
                    //       shape: BoxShape.circle,
                    //     ),
                    //     child: Image.asset(
                    //       'assets/images/logo.png',
                    //       height: 100,
                    //       width: 100,
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 24),
                    const TitleHeaderWidget(
                      title: 'Welcome Back',
                    ),
                    const Text(
                      'Please sign in to continue',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 32),
                    CustomTextFieldWidget(
                      controller: viewModel.usernameController.value,
                      title: "Email",
                      hintText: "Enter your email",
                      prefixIcon: const Icon(Icons.email_outlined),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    Obx(() => CustomTextFieldWidget(
                      controller: viewModel.passwordController.value,
                      title: "Password",
                      hintText: "Enter your password",
                      prefixIcon: const Icon(Icons.lock_outline),
                      obscureText: !viewModel.isPasswordVisible.value,
                      suffixIcon: IconButton(
                        icon: Icon(
                          viewModel.isPasswordVisible.value 
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                          color: Colors.grey,
                        ),
                        onPressed: () => viewModel.togglePasswordVisibility(),
                      ),
                    )),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => viewModel.onLogin(),
                        child: viewModel.isLoginLoading.value
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text(
                              'LogIn',
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        TextButton(
                          onPressed: () => Get.toNamed('/register'),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.indigo,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
