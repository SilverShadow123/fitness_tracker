import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _users =>
      _db.collection('users');

  CollectionReference<Map<String, dynamic>> _healthCol(String uid) =>
      _users.doc(uid).collection('healthData');

  CollectionReference<Map<String, dynamic>> _dailyGoalsHistoryCol(String uid) =>
      _users.doc(uid).collection('dailyGoalsHistory');

  // Method to add user profile
  Future<void> addUser(
      String uid,
      String name,
      String email,
      String height,
      String weight,
      String age,
      String gender,
      ) async {
    final data = <String, dynamic>{
      'name': name,
      'email': email,
      'height': height,
      'weight': weight,
      'age': age,
      'gender': gender,
      'createdAt': FieldValue.serverTimestamp(),
    };

    try {
      await _users.doc(uid).set(data);
    } catch (e) {
      throw Exception('Error adding user profile: $e');
    }
  }

  // Method to get user profile
  Future<Map<String, dynamic>?> getUserProfile(String uid) async {
    try {
      final doc = await _users.doc(uid).get();
      if (doc.exists) return doc.data();
    } catch (e) {
      print('Error fetching user profile: $e');
    }
    return null;
  }

  // Method to add or set daily goal
  Future<void> addOrSetDailyGoal(
      String uid, {
        double? calories,
        double? targetsleep,
        double? targetwater,
        double? steps,
        double? bmi,
        String? description,
      }) async {
    final data = <String, dynamic>{
      if (calories != null) 'calories': calories,
      if (targetsleep != null) 'targetsleep': targetsleep,
      if (targetwater != null) 'targetwater': targetwater,
      if (steps != null) 'steps': steps,
      if (bmi != null) 'bmi': bmi,
      'entry': 'dailyGoal',
      'description': description ?? '',
      'createdAt': FieldValue.serverTimestamp(),
    };

    try {
      // Save the current daily goal data to history before updating
      final currentGoalDoc = await _healthCol(uid).doc('dailyGoal').get();
      if (currentGoalDoc.exists) {
        // Save the existing daily goal data into the history collection
        await _dailyGoalsHistoryCol(uid).add({
          ...currentGoalDoc.data()!,
          'savedAt': FieldValue.serverTimestamp(),
        });
      }

      // Set the new daily goal
      await _healthCol(uid).doc('dailyGoal').set(data, SetOptions(merge: true));
    } catch (e) {
      throw Exception('Error setting daily goal: $e');
    }
  }

  // Method to update the daily goal
  Future<void> updateDailyGoal(
      String uid, {
        double? calories,
        double? targetsleep,
        double? targetwater,
        double? steps,
        double? bmi,
      }) async {
    final data = <String, dynamic>{
      if (calories != null) 'calories': calories,
      if (targetsleep != null) 'targetsleep': targetsleep,
      if (targetwater != null) 'targetwater': targetwater,
      if (steps != null) 'steps': steps,
      if (bmi != null) 'bmi': bmi,
    };

    try {
      // Save the current daily goal data to history before updating
      final currentGoalDoc = await _healthCol(uid).doc('dailyGoal').get();
      if (currentGoalDoc.exists) {
        // Save the existing daily goal data into the history collection
        await _dailyGoalsHistoryCol(uid).add({
          ...currentGoalDoc.data()!,
          'savedAt': FieldValue.serverTimestamp(),
        });
      }

      // Update the daily goal
      await _healthCol(uid).doc('dailyGoal').update(data);
    } catch (e) {
      throw Exception('Error updating daily goal: $e');
    }
  }

  // Stream the daily goal document
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamDailyGoal(String uid) {
    return _healthCol(uid).doc('dailyGoal').snapshots();
  }

  // Method to get daily goals history
  Future<List<Map<String, dynamic>>> getDailyGoalsHistory(String uid) async {
    try {
      final snapshot = await _dailyGoalsHistoryCol(uid)
          .orderBy('savedAt', descending: true)
          .get();

      return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      throw Exception('Error fetching daily goals history: $e');
    }
  }
  // Method to update user profile
  Future<void> updateUserProfile(
      String uid, {
        String? name,
        String? email,
        String? height,
        String? weight,
        String? age,
        String? gender,
      }) async {
    final data = <String, dynamic>{
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (height != null) 'height': height,
      if (weight != null) 'weight': weight,
      if (age != null) 'age': age,
      if (gender != null) 'gender': gender,
      'updatedAt': FieldValue.serverTimestamp(),
    };

    try {
      await _users.doc(uid).update(data);
    } catch (e) {
      throw Exception('Error updating user profile: $e');
    }
  }

  // Delete the daily goal
  Future<void> deleteDailyGoal(String uid) async {
    try {
      // Save the current daily goal data to history before deleting
      final currentGoalDoc = await _healthCol(uid).doc('dailyGoal').get();
      if (currentGoalDoc.exists) {
        // Save the existing daily goal data into the history collection
        await _dailyGoalsHistoryCol(uid).add({
          ...currentGoalDoc.data()!,
          'savedAt': FieldValue.serverTimestamp(),
        });
      }

      // Delete the daily goal
      await _healthCol(uid).doc('dailyGoal').delete();
    } catch (e) {
      throw Exception('Error deleting daily goal: $e');
    }
  }
  Future<String?> getUserGender(String uid) async {
    try {
      final doc = await _users.doc(uid).get();
      if (doc.exists) {
        return doc.data()?['gender'] as String?;
      }
    } catch (e) {
      throw Exception('Error fetching gender: $e');
    }
    return null;
  }
  Future<Map<String, double>?> getUserHeightAndWeight(String uid) async {
    try {
      final doc = await _users.doc(uid).get();
      if (doc.exists) {
        final data = doc.data();
        final height = double.tryParse(data?['height'] ?? '');
        final weight = double.tryParse(data?['weight'] ?? '');

        if (height != null && weight != null) {
          return {
            'height': height,
            'weight': weight,
          };
        }
      }
    } catch (e) {
      throw Exception('Error fetching height and weight: $e');
    }
    return null;
  }


}
