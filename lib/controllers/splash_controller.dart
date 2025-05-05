import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_tracker/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  /// Initialize Firebase and then navigate to the home screen.
  Future<void> initializeFirebase() async {
    try {
      // Wait for Firebase initialization
      await Firebase.initializeApp();

      // Check if the user is logged in
      if (FirebaseAuth.instance.currentUser != null) {
        // Navigate to the home screen
        Get.offAllNamed(AppRoutes.home);
      } else {
        // Navigate to the login screen
        Get.offAllNamed(AppRoutes.login);
      }
    } catch (e) {
      // If Firebase initialization fails, show an error message
      Get.snackbar(
        'Error',
        'Failed to initialize Firebase: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize Firebase when the controller is first loaded
    initializeFirebase();
  }
}
