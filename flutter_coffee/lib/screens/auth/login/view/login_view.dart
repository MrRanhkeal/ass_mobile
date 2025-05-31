import 'package:flutter/material.dart';
import 'package:flutter_coffee/screens/auth/login/view_model/login_view_model.dart';
import 'package:flutter_coffee/widgets/custom_button_widget.dart';
import 'package:flutter_coffee/widgets/custom_text_field_widget.dart';
import 'package:flutter_coffee/widgets/title_header_widget.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  var viewModel = Get.put(LoginViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.indigo,
        title: Text(
          "Login",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body:Obx((){
        return Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 600, maxHeight: 600),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TitleHeaderWidget(
                    title: "Login to \n Mobile App",
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  CustomTextFieldWidget(
                    controller: viewModel.usernameController.value,
                    title: "Username or Email",
                    prefixIcon: const Icon(Icons.email),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFieldWidget(
                    controller: viewModel.passwordController.value,
                    title: "Password",
                    prefixIcon: const Icon(Icons.lock),
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  CustomButtonWidget(
                    isLoading: viewModel.isLoginLoading.value,
                    onTab: () {
                      viewModel.onLogin();
                    },
                    backgroundColor: Colors.indigo,
                    title: "Login",
                  )
                ],
              ),
            ),
          ),
        );
      })
    );
  }
}
