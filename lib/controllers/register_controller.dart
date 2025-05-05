import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../firebase/service/fireservice.dart';
import '../routes/app_routes.dart';

class RegisterController extends GetxController {
  final TextEditingController nameTEController = TextEditingController();
  final TextEditingController emailTEController = TextEditingController();
  final TextEditingController passwordTEController = TextEditingController();
  final TextEditingController confirmPasswordTEController = TextEditingController();
  final TextEditingController heightTEController = TextEditingController();
  final TextEditingController weightTEController = TextEditingController();
  final TextEditingController ageTEController = TextEditingController();
  final TextEditingController genderTEController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void onClose() {
    nameTEController.dispose();
    emailTEController.dispose();
    passwordTEController.dispose();
    confirmPasswordTEController.dispose();
    heightTEController.dispose();
    weightTEController.dispose();
    ageTEController.dispose();
    genderTEController.dispose();
    super.onClose();
  }

  void register() async {
    String name = nameTEController.text.trim();
    String email = emailTEController.text.trim();
    String password = passwordTEController.text.trim();
    String confirmPassword = confirmPasswordTEController.text.trim();
    String height = heightTEController.text.trim();
    String weight = weightTEController.text.trim();
    String age = ageTEController.text.trim();
    String gender = genderTEController.text.trim();


    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        height.isEmpty ||
        weight.isEmpty ||
        age.isEmpty
    || gender.isEmpty
    ) {
      Get.snackbar("Error", "All fields are required");
      return;
    }

    if (gender != 'Male' && gender != 'Female' && gender != 'male' && gender !='female' ) {
      Get.snackbar("Error", "Gender has to be either Male or Female");
      return;
    } if (password != confirmPassword) {
      Get.snackbar("Error", "Passwords do not match");
      return;
    }

    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Add user to Firestore
      String uid = userCredential.user!.uid;
      await _firestoreService.addUser(uid, name, email, height, weight, age, gender);

      Get.back(); // remove loading
      Get.toNamed(AppRoutes.login);
    } on FirebaseAuthException catch (e) {
      Get.back();
      Get.snackbar("Auth Error", e.message ?? "Unknown error");
    } catch (e) {
      Get.back();
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }

  void navigateToLogin() {
    Get.back(canPop: true);
  }
}
