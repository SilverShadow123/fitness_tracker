import 'package:cloud_firestore/cloud_firestore.dart';

class JournalService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Reference to the user's journal collection
  CollectionReference<Map<String, dynamic>> _journalCollection(String uid) =>
      _db.collection('users').doc(uid).collection('journals');

  // Add or update a journal entry for a specific date
  Future<void> addOrUpdateJournalEntry(
    String uid,
    DateTime date,
    String title,
    String description,
  ) async {
    final dateId = _formatDate(date);

    final data = {
      'title': title,
      'description': description,
      'createdAt': FieldValue.serverTimestamp(),
    };

    await _journalCollection(
      uid,
    ).doc(dateId).set(data); // Add or update the journal for the specific date
  }

  // Get the journal entry for a specific date
  Future<Map<String, dynamic>?> getJournalEntry(
    String uid,
    DateTime date,
  ) async {
    final dateId = _formatDate(date);
    final doc = await _journalCollection(uid).doc(dateId).get();

    if (doc.exists) {
      return doc.data();
    }
    return null; // Return null if no journal entry exists for that date
  }

  // Get all journal entries for a user (optional)
  Future<List<Map<String, dynamic>>> getAllJournalEntries(String uid) async {
    final snapshot =
        await _journalCollection(uid)
            .orderBy(
              'createdAt',
              descending: true,
            ) // Order by createdAt for recent entries
            .get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  // Helper function to format the date to YYYY-MM-DD
  String _formatDate(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
}
