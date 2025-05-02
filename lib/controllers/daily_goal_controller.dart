import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../model/health_entry.dart';

class DailyGoalsController extends GetxController {
  var isCaloriesExpanded = false.obs;
  var isStepsExpanded = false.obs;
  var isSleepExpanded = false.obs;
  var isWaterIntakeExpanded = false.obs;
  var isBMIExpanded = false.obs;

  void toggleCalories() => isCaloriesExpanded.toggle();
  void toggleSteps() => isStepsExpanded.toggle();
  void toggleSleep() => isSleepExpanded.toggle();
  void toggleWaterIntake() => isWaterIntakeExpanded.toggle();
  void toggleBMI() => isBMIExpanded.toggle();

  final goalModel = Rxn<DailyGoalModel>();

  String get uid => FirebaseAuth.instance.currentUser?.uid ?? '';

  @override
  void onInit() {
    super.onInit();
    fetchDailyGoals();
  }

  void fetchDailyGoals() {
    if (uid.isEmpty) return;

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('healthData')
        .orderBy('createdAt', descending: true)
        .limit(1)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        goalModel.value = DailyGoalModel.fromMap(snapshot.docs.first.data());
      }
    });
  }
}
