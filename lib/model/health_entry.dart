class DailyGoalModel {
  final double? calories;
  final double? steps;
  final double? sleepGoal;
  final double? waterGoal;
  final double? bmiGoal;

  DailyGoalModel({
    this.calories,
    this.steps,
    this.sleepGoal,
    this.waterGoal,
    this.bmiGoal,
  });

  factory DailyGoalModel.fromMap(Map<String, dynamic> map) {
    return DailyGoalModel(
      calories: (map['calories'] ?? 0).toDouble(),
      steps: (map['steps'] ?? 0).toDouble(),
      sleepGoal: (map['targetsleep'] ?? 0).toDouble(),
      waterGoal: (map['targetwater'] ?? 0).toDouble(),
      bmiGoal: (map['bmi'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'calories': calories,
      'steps': steps,
      'targetsleep': sleepGoal,
      'targetwater': waterGoal,
      'bmi': bmiGoal,
    };
  }
}
