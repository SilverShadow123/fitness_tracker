class DailyGoalModel {
  final int calories;
  final int caloriesConsumed;
  final int steps;
  final int stepsTaken;
  final double bmiGoal;
  final double bmiCurrent;
  final int sleepGoal;
  final int sleepTaken;
  final int waterGoal;
  final int waterTaken;

  DailyGoalModel({
    required this.calories,
    required this.caloriesConsumed,
    required this.steps,
    required this.stepsTaken,
    required this.bmiGoal,
    required this.bmiCurrent,
    required this.sleepGoal,
    required this.sleepTaken,
    required this.waterGoal,
    required this.waterTaken,
  });

  factory DailyGoalModel.fromMap(Map<String, dynamic> map) {
    return DailyGoalModel(
      calories: map['caloriesGoal'] ?? 2000,
      caloriesConsumed: map['caloriesConsumed'] ?? 1500,
      steps: map['stepsGoal'] ?? 10000,
      stepsTaken: map['stepsTaken'] ?? 6000,
      bmiGoal: (map['bmiGoal'] ?? 22.5).toDouble(),
      bmiCurrent: (map['currentBmi'] ?? 23.0).toDouble(),
      sleepGoal: map['sleepGoal'] ?? 8,
      sleepTaken: map['sleepTaken'] ?? 4,
      waterGoal: map['waterGoal'] ?? 2000,
      waterTaken: map['waterTaken'] ?? 800,
    );
  }
}
