import 'package:fitness_tracker/controllers/cal_bmi_other_calculation_controller.dart';
import 'package:fitness_tracker/controllers/daily_goal_controller.dart';
import 'package:fitness_tracker/controllers/journal_controller.dart';
import 'package:fitness_tracker/controllers/step_calculation_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../controllers/profile_controller.dart';
import '../firebase/service/fireservice.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<DailyGoalsController>(() => DailyGoalsController());
    Get.lazyPut<JournalController>(() => JournalController());
    Get.lazyPut<StepCalculationController>(() => StepCalculationController());
    Get.lazyPut<HealthCalculationController>(() => HealthCalculationController());
    Get.lazyPut<FirestoreService>(() => FirestoreService());
  }
}