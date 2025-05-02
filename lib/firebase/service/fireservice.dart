// lib/services/firestore_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Reference to the top‑level users collection
  CollectionReference<Map<String, dynamic>> get _users =>
      _db.collection('users');

  /// Reference to users/{uid}/healthData sub‑collection
  CollectionReference<Map<String, dynamic>> _healthCol(String uid) =>
      _users.doc(uid).collection('healthData');

  /// Create or overwrite a user profile document
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
      'name':      name,
      'email':     email,
      'height':    height,
      'weight':    weight,
      'age':       age,
      'gender':    gender,
      'createdAt': FieldValue.serverTimestamp(),
    };

    try {
      await _users.doc(uid).set(data);
    } catch (e) {
      throw Exception('Error adding user profile: $e');
    }
  }

  /// Add a health entry (goals or daily update)
  Future<void> addHealthEntry(
      String uid, {
        double? calories,
        double? targetsleep,
        double? targetwater,
        double? steps,
        double? bmi,
        double? todaysleep,
        double? todaywater,
        String? entry,
        String? description,
      }) async {
    final data = <String, dynamic>{
      if (calories    != null) 'calories':    calories,
      if (targetsleep != null) 'targetsleep': targetsleep,
      if (targetwater != null) 'targetwater': targetwater,
      if (steps       != null) 'steps':       steps,
      if (bmi         != null) 'bmi':         bmi,
      if (todaysleep  != null) 'todaysleep':  todaysleep,
      if (todaywater  != null) 'todaywater':  todaywater,
      'entry':       entry ?? '',
      'description': description ?? '',
      'createdAt':   FieldValue.serverTimestamp(),
    };

    try {
      await _healthCol(uid).add(data);
    } catch (e) {
      throw Exception('Error adding health entry: $e');
    }
  }

  /// Stream all health entries for a user, ordered by creation time desc
  Stream<QuerySnapshot<Map<String, dynamic>>> streamHealthEntries(String uid) {
    return _healthCol(uid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// Delete a health entry by document ID
  Future<void> deleteHealthEntry(String uid, String entryId) async {
    try {
      await _healthCol(uid).doc(entryId).delete();
    } catch (e) {
      throw Exception('Error deleting health entry: $e');
    }
  }
}
