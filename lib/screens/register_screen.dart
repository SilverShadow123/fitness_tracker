import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fitness_tracker/widgets/button_auth.dart';
import 'package:fitness_tracker/widgets/login_register_text_field.dart';

import '../controllers/register_controller.dart';

class RegisterScreen extends GetView {
  RegisterScreen({super.key});

  @override
  final RegisterController controller = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 56),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title
                AnimatedOpacity(
                  opacity: 1.0,
                  duration: Duration(seconds: 1),
                  child: const Text(
                    'Register to Fitnessify',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Input Fields with animations
                _buildInputField(controller.nameTEController, 'Name'),
                _buildInputField(
                  controller.ageTEController,
                  'Age',
                  isNumber: true,
                ),
                _buildInputField(
                  controller.heightTEController,
                  'Height(cm)',
                  isNumber: true,
                ),
                _buildInputField(
                  controller.weightTEController,
                  'Weight(kg)',
                  isNumber: true,
                ),
                _buildInputField(controller.genderTEController, 'Gender'),
                _buildInputField(controller.emailTEController, 'Email'),
                _buildInputField(
                  controller.passwordTEController,
                  'Password',
                  obscureText: true,
                ),
                _buildInputField(
                  controller.confirmPasswordTEController,
                  'Confirm Password',
                  obscureText: true,
                ),

                const SizedBox(height: 24),

                // Register Button
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  child: ButtonAuth(
                    text: 'Register',
                    onPressed: controller.register,
                  ),
                ),

                const SizedBox(height: 16),

                // Already have an account text
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

  // Reusable input field widget with animations
  Widget _buildInputField(
    TextEditingController controller,
    String labelText, {
    bool isNumber = false,
    bool obscureText = false,
  }) {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: Duration(seconds: 1),
      child: Column(
        children: [
          TextFieldAuth(
            controller: controller,
            labelText: labelText,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            obscureText: obscureText,
            hintText: labelText,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
