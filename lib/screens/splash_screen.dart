import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashScreen extends GetView<SplashController>{
  SplashScreen({super.key});

  final SplashController splashController = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fitness_center, size: 104, color: Colors.blue),
            const SizedBox(height: 24),
            const Text(
              'Welcome to Fitnessify',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your fitness journey starts here',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            CircularProgressIndicator(
              color: Colors.blue[900],
            ),
          ],
        ),
      ),
    );
  }
}
