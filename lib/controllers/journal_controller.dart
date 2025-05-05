import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../firebase/service/journal_service.dart';

class JournalController extends GetxController with GetTickerProviderStateMixin {
  final currentMonth = DateTime.now().obs;
  final selectedDate = DateTime.now().obs;

  late AnimationController animationController;
  late Animation<Offset> slideAnimation;

  final forward = true.obs;
  final entries = <Map<String, dynamic>>[].obs;

  // Loading state
  final isLoading = false.obs;

  final JournalService _journalService = JournalService();

  static const List<String> monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];

  String get monthLabel =>
      '${monthNames[currentMonth.value.month - 1]} ${currentMonth.value.year}';

  void initController(TickerProvider vsync, String uid) {
    animationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 400),
    );
    _setAnimation();
    animationController.forward();
    loadJournalEntries(uid);
  }

  void _setAnimation() {
    slideAnimation = Tween<Offset>(
      begin: Offset(forward.value ? 1 : -1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );
  }

  void changeMonth(int delta, String uid) {
    forward.value = delta > 0;
    _setAnimation();
    animationController.reset();

    currentMonth.value = DateTime(currentMonth.value.year, currentMonth.value.month + delta);
    selectedDate.value = DateTime(currentMonth.value.year, currentMonth.value.month, 1);

    animationController.forward();
    loadJournalEntries(uid);
  }

  void changeSelectedDate(DateTime date, String uid) {
    selectedDate.value = date;
    loadJournalEntries(uid);
  }

  Future<void> loadJournalEntries(String uid) async {
    isLoading.value = true; // Show loading indicator
    try {
      entries.clear();
      final fetched = await _journalService.getJournalEntriesForDate(uid, selectedDate.value);
      entries.assignAll(fetched);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load journal entries', snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false; // Hide loading indicator
    }
  }

  Future<void> addJournalEntry(String uid, String title, String description) async {
    isLoading.value = true; // Show loading indicator
    try {
      await _journalService.addJournalEntry(uid, selectedDate.value, title, description);
      await loadJournalEntries(uid); // Refresh after adding
    } catch (e) {
      Get.snackbar('Error', 'Failed to add journal entry', snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false; // Hide loading indicator
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
