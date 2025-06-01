import 'package:flutter/material.dart';
import 'package:flutter_coffee/app/routes.dart';
import 'package:flutter_coffee/screens/auth/register/view_models/register_view_model.dart';
import 'package:flutter_coffee/widgets/custom_text_field_widget.dart';
import 'package:get/get.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final RegisterViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = Get.put(RegisterViewModel());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Get.back(),
        ),
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: Obx(() {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Text(
                    '*',
                    style: TextStyle(color: Colors.red),
                  ),
                  Text(
                    ' Name',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              CustomTextFieldWidget(
                controller: viewModel.nameController.value,
                // title: 'User Name',
                hintText: 'User Name',
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Text(
                    '*',
                    style: const TextStyle(color: Colors.red),
                  ),
                  const Text(
                    ' Email',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              CustomTextFieldWidget(
                controller: viewModel.usernameController.value,
                // title: 'Email',
                hintText: 'Email',
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Text(
                    '*',
                    style: const TextStyle(color: Colors.red),
                  ),
                  const Text(
                    ' password',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Obx(() => CustomTextFieldWidget(
                controller: viewModel.passwordController.value,
                hintText: 'password',
                obscureText: !viewModel.isPasswordVisible.value,
                suffixIcon: IconButton(
                  icon: Icon(
                    viewModel.isPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () => viewModel.togglePasswordVisibility(),
                ),
              )),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Text(
                    '*',
                    style: TextStyle(color: Colors.red),
                  ),
                  Text(
                    ' Confirm Password',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Obx(() => CustomTextFieldWidget(
                controller: viewModel.confirmPasswordController.value,
                hintText: 'confirm password',
                obscureText: !viewModel.isConfirmPasswordVisible.value,
                suffixIcon: IconButton(
                  icon: Icon(
                    viewModel.isConfirmPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () => viewModel.toggleConfirmPasswordVisibility(),
                ),
              )),
              // const SizedBox(height: 16),
              // Row(
              //   children: const [
              //     Text(
              //       '*',
              //       style: TextStyle(color: Colors.red),
              //     ),
              //     Text(
              //       ' Status',
              //       style: TextStyle(fontSize: 16),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 8),
              // Container(
              //   decoration: BoxDecoration(
              //     border: Border.all(color: const Color.fromARGB(255, 158, 158, 158)),
              //     borderRadius: BorderRadius.circular(4),
              //   ),
              //   child: DropdownButton<String>(
              //     isExpanded: true,
              //     underline: const SizedBox(),
              //     padding: const EdgeInsets.symmetric(horizontal: 12),
              //     hint: const Text('Select Status'),
                  
              //     icon: const Icon(Icons.arrow_drop_down),
              //     items: const [
              //       DropdownMenuItem<String>(
              //         value: 'active',
              //         child: Text('Active'),
              //       ),
              //       DropdownMenuItem<String>(
              //         value: 'inactive',
              //         child: Text('Inactive'),
              //       ),
              //     ],
                  
              //     onChanged: (items) {},
              //   ),
              // ),
              // const SizedBox(height: 24),
              const SizedBox(height: 24),
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: 200,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => viewModel.onRegister(),
                        child: viewModel.isRegisterLoading.value
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : const Text(
                                'Register',
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Get.offAllNamed('/login');
                      },
                      child: const Text(
                        'Back to Login',
                        style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
