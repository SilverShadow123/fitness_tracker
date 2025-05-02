import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/register_controller.dart';
import '../widgets/button_auth.dart';
import '../widgets/login_register_text_field.dart';

class RegisterScreen extends GetView {
  RegisterScreen({super.key});

  @override
  final RegisterController controller = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 56),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Register to Fitnessify',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                TextFieldAuth(
                  controller: controller.nameTEController,
                  labelText: 'Name',
                  obscureText: false,
                  hintText: 'Name',
                ),
                const SizedBox(height: 24),
                TextFieldAuth(
                  controller: controller.ageTEController,
                  labelText: 'Age',
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  hintText: 'Age',
                ),
                const SizedBox(height: 24),
                TextFieldAuth(
                  controller: controller.heightTEController,
                  labelText: 'Height',
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  hintText: 'Height(cm)',
                ),
                const SizedBox(height: 24),
                TextFieldAuth(
                  controller: controller.weightTEController,
                  labelText: 'Weight',
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  hintText: 'Weight(kg)',
                ),
                const SizedBox(height: 24),
                TextFieldAuth(
                  controller: controller.genderTEController,
                  labelText: 'Gender',
                  obscureText: false,
                  hintText: 'Male or Female',
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
                  obscureText: false,
                  hintText: 'Password',
                ),
                const SizedBox(height: 24),
                TextFieldAuth(
                  controller: controller.confirmPasswordTEController,
                  labelText: 'Confirm Password',
                  obscureText: false,
                  hintText: 'Confirm Password',
                ),

                const SizedBox(height: 24),
                ButtonAuth(text: 'Register', onPressed: controller.register),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.navigateToLogin();
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
