import 'package:fitness_tracker/controllers/step_calculation_controller.dart';
import 'package:get/get.dart';

class HealthCalculationController extends GetxController {

  final StepCalculationController stepController = Get.find<StepCalculationController>();

  RxDouble bmi = 0.0.obs;
  RxDouble calories = 0.0.obs;
  RxDouble waterIntake = 0.0.obs; // in milliliters
  RxInt sleepHours = 0.obs; // in hours

  // Calculate BMI based on weight and height
  void calculateBMI(double weight, double height) {
    if (weight > 0 && height > 0) {
      bmi.value = weight / (height * height); // BMI formula: weight(kg) / height(m)^2
    } else {
      bmi.value = 0.0;  // Handle invalid input
    }
  }

  // Calculate calories burned based on steps and weight
  void calculateCalories() {
    double weight = 68.5; // Example weight in kg
    if (weight > 0 && stepController.stepCount.value >= 0) {
      calories.value = stepController.stepCount.value * weight * 0.04; // Basic formula for calories burned
    } else {
      calories.value = 0.0;  // Handle invalid input
    }
  }

  // Calculate daily water intake (30-35 ml per kg of body weight)
  void calculateWaterIntake(double weight) {
    if (weight > 0) {
      waterIntake.value = weight * 30; // Minimum water intake (in ml)
      // waterIntake.value = weight * 35; // For higher intake
    } else {
      waterIntake.value = 0.0;  // Handle invalid input
    }
  }

  // Set the number of hours of sleep
  void setSleepHours(int hours) {
    if (hours >= 0) {
      sleepHours.value = hours;
    } else {
      sleepHours.value = 0; // Handle invalid input
    }
  }
}
