import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../model/health_entry.dart';
import '../firebase/service/fireservice.dart';
import 'cal_bmi_other_calculation_controller.dart';

class DailyGoalsController extends GetxController {
  final FirestoreService _firestoreService = Get.find();
  final healthController = Get.find<HealthCalculationController>();

  var isCaloriesExpanded = false.obs;
  var isStepsExpanded = false.obs;
  var isSleepExpanded = false.obs;
  var isWaterIntakeExpanded = false.obs;
  var isBMIExpanded = false.obs;

  var waterIntake = 0.obs;
  var sleepHours = 0.obs;

  void toggleCalories() => isCaloriesExpanded.toggle();

  void toggleSteps() => isStepsExpanded.toggle();

  void toggleSleep() => isSleepExpanded.toggle();

  void toggleWaterIntake() => isWaterIntakeExpanded.toggle();

  void toggleBMI() => isBMIExpanded.toggle();

  final goalModel = Rxn<DailyGoalModel>();

  String get uid => FirebaseAuth.instance.currentUser?.uid ?? '';

  double calculateTotalProgress(
    double calories,
    int steps,
    double sleep,
    double water,
    double currentBmi,
  ) {
    final calorieProgress = (calories / (goalModel.value?.calories ?? 1000))
        .clamp(0.0, 1.0);
    final stepProgress = (steps / 10000).clamp(0.0, 1.0);
    final sleepProgress = (sleep / (goalModel.value?.sleepGoal ?? 8)).clamp(
      0.0,
      1.0,
    );
    final waterProgress = (water / (goalModel.value?.waterGoal ?? 2)).clamp(
      0.0,
      1.0,
    );
    final bmiGoal = goalModel.value?.bmiGoal ?? 22.5;
    final bmiProgress = (1 - ((currentBmi - bmiGoal).abs() / bmiGoal)).clamp(
      0.0,
      1.0,
    );

    return (calorieProgress +
            stepProgress +
            sleepProgress +
            waterProgress +
            bmiProgress) /
        5;
  }

  @override
  void onInit() {
    super.onInit();
    fetchDailyGoals();
  }

  void fetchDailyGoals() {
    if (uid.isEmpty) return;

    _firestoreService.streamDailyGoal(uid).listen((doc) {
      if (doc.exists) {
        goalModel.value = DailyGoalModel.fromMap(doc.data()!);
      }
    });
  }

  Future<void> setOrUpdateGoals({
    double? calories,
    double? steps,
    double? sleepGoal,
    double? waterGoal,
    double? bmiGoal,
  }) async {
    if (uid.isEmpty) return;

    await _firestoreService.addOrSetDailyGoal(
      uid,
      calories: calories,
      steps: steps,
      targetsleep: sleepGoal,
      targetwater: waterGoal,
      bmi: bmiGoal,
    );
  }

  void updateWaterIntake() {
    waterIntake.value++;
  }

  void updateSleepHours() {
    sleepHours.value++;
  }

  Future<void> resetGoals() async {
    if (uid.isEmpty) return;

    await _firestoreService.addOrSetDailyGoal(
      uid,
      calories: 0,
      steps: 0,
      targetsleep: 0,
      targetwater: 0,
      bmi: 0,
    );
  }
}
