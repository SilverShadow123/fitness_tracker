import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../widgets/button_auth.dart';
import '../widgets/login_register_text_field.dart';


class LoginScreen extends GetView<LoginController> {
  LoginScreen({super.key});

  final LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              const Text(
                'Welcome to Fitnessify',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              TextFieldAuth(
                controller: controller.emailTEController,
                labelText: 'Email',
                obscureText: false,
                hintText: 'Email',
              ),
              const SizedBox(height: 24),
              TextFieldAuth(
                controller: controller.passwordTEController,
                labelText: 'Password',
                obscureText: true,
                hintText: 'Password',
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: (){},
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ButtonAuth(text: 'Login', onPressed: controller.login),
              const SizedBox(height: 32),
              Text(
                'Don\'t have an account?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              TextButton(
                onPressed: () {
                  controller.navigateToRegister();
                },
                child: const Text(
                  'Register Here',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}