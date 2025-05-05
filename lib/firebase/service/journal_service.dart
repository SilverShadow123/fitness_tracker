import 'package:cloud_firestore/cloud_firestore.dart';

class JournalService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _journalCollection(String uid) =>
      _db.collection('users').doc(uid).collection('journals');

  Future<void> addJournalEntry(
      String uid,
      DateTime date,
      String title,
      String description,
      ) async {
    final dateId = _formatDate(date); // e.g. 2025-05-06
    final journalRef = _journalCollection(uid).doc(dateId).collection('entries');

    final data = {
      'title': title,
      'description': description,
      'createdAt': FieldValue.serverTimestamp(),
    };

    await journalRef.add(data);
  }

  Future<List<Map<String, dynamic>>> getJournalEntriesForDate(String uid, DateTime date) async {
    final dateId = _formatDate(date);
    final snapshot = await _journalCollection(uid)
        .doc(dateId)
        .collection('entries')
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  String _formatDate(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}
