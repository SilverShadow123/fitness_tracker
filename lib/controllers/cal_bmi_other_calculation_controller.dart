import 'package:firebase_auth/firebase_auth.dart';
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
    fetchUserDataAndCalculate();
  }

  Future<void> fetchUserDataAndCalculate() async {
    if (uid.isEmpty) return;

    final profile = await firestoreService.getUserProfile(uid);
    if (profile != null) {
      weight.value = (profile['weight'] ?? 0.0).toDouble();
      height.value = (profile['height'] ?? 0.0).toDouble();

      calculateBMI(weight.value, height.value);
      calculateCalories();
    }
  }

  void calculateBMI(double weight, double height) {
    if (weight > 0 && height > 0) {
      bmi.value = weight / (height * height);
    } else {
      bmi.value = 0.0;
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
