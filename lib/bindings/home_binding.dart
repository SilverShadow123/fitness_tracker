import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../controllers/profile_controller.dart';
import '../controllers/daily_goal_controller.dart';
import '../controllers/journal_controller.dart';
import '../controllers/step_calculation_controller.dart';
import '../controllers/cal_bmi_other_calculation_controller.dart';
import '../firebase/service/fireservice.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    final uid = FirebaseAuth.instance.currentUser?.uid ?? '';

    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ProfileController>(() {
      final controller = ProfileController();
      controller.setUid(uid); // ✅ Set UID here
      return controller;
    });
    Get.lazyPut<DailyGoalsController>(() => DailyGoalsController());
    Get.lazyPut<JournalController>(() => JournalController());
    Get.lazyPut<StepCalculationController>(() => StepCalculationController());
    Get.lazyPut<HealthCalculationController>(
      () => HealthCalculationController(),
    );
    Get.lazyPut<FirestoreService>(() => FirestoreService());
  }
}
