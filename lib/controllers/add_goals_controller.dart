import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness_tracker/firebase/service/fireservice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GoalsController extends GetxController {

  final FirestoreService _firestoreService = FirestoreService();
  // Controllers for Goals tab
  final stepsController = TextEditingController();
  final caloriesController = TextEditingController();
  final targetSleepController = TextEditingController();
  final waterGoalController = TextEditingController();
  final bmiController = TextEditingController();

  // Controllers for Update tab
  final todaySleepController = TextEditingController();
  final todayWaterController = TextEditingController();


  String get uid => FirebaseAuth.instance.currentUser?.uid ?? '';
  // Get current user's email
  String get email => FirebaseAuth.instance.currentUser?.email ?? '';
  // Get current user's name
  String get name => FirebaseAuth.instance.currentUser?.displayName ?? '';

  void saveGoals() {
    // TODO: Implement actual save logic
    String steps = stepsController.text.trim();
    String calories = caloriesController.text.trim();
    String targetSleep = targetSleepController.text.trim();
    String waterGoal = waterGoalController.text.trim();
    String bmi = bmiController.text.trim();
    setGoals(steps,calories,targetSleep,waterGoal,bmi);
    print("Saved Goals");
    Get.back();
  }
Future<void> setGoals(String steps,String calories,String targetSleep,String waterGoal,String bmi) async {

    if (steps.isEmpty || calories.isEmpty || targetSleep.isEmpty || waterGoal.isEmpty || bmi.isEmpty) {
      Get.snackbar("Error", "All fields are required");
      return;
    }
    try {
      await _firestoreService.addOrSetDailyGoal(
        uid,
        calories: double.parse(calories),
        targetsleep: double.parse(targetSleep),
        targetwater: double.parse(waterGoal),
        steps: double.parse(steps),
        bmi: double.parse(bmi),
      );
      Get.snackbar("Success", "Goals saved successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to save goals");
    }
}





  @override
  void onClose() {
    stepsController.dispose();
    caloriesController.dispose();
    targetSleepController.dispose();
    waterGoalController.dispose();
    bmiController.dispose();
    todaySleepController.dispose();
    todayWaterController.dispose();
    super.onClose();
  }
}
