import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../firebase/service/fireservice.dart';
import 'step_calculation_controller.dart';

class HealthCalculationController extends GetxController {
  final StepCalculationController stepController = Get.find<StepCalculationController>();
  final FirestoreService firestoreService = Get.find<FirestoreService>();

  RxDouble bmi = 0.0.obs;
  RxDouble calories = 0.0.obs;
  RxDouble waterIntake = 0.0.obs;
  RxInt sleepHours = 0.obs;

  RxDouble weight = 0.0.obs;
  RxDouble height = 0.0.obs;

  String get uid => FirebaseAuth.instance.currentUser?.uid ?? '';

  @override
  void onInit() {
    super.onInit();
calculateBMI();
  }


  void calculateBMI() async {
    final result = await firestoreService.getUserHeightAndWeight(uid);

    if (result != null) {
      weight.value = result['weight']!;
      height.value = result['height']! / 100; // convert cm to meters

      if (weight.value > 0 && height.value > 0) {
        bmi.value = weight.value / (height.value * height.value);
      } else {
        bmi.value = 0.0;
      }
    } else {
      bmi.value = 0.0;
    }
  }
   Widget bmiChart() {
    if (bmi.value < 18.5) {
    return Text('Underweight');
    } else if (bmi.value >= 18.5 && bmi.value < 24.9) {
     return Text('Normal');
    } else if (bmi.value >= 25 && bmi.value < 29.9) {
    return Text("Overweight");
    } else {
     return Text("Obesity");
    }
  }


  void calculateCalories() {
    if (weight.value > 0 && stepController.stepCount.value >= 0) {
      calories.value = stepController.stepCount.value * weight.value * 0.04;
    } else {
      calories.value = 0.0;
    }
  }


}
