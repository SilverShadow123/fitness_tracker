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
    loadJournalEntry(uid);
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

    currentMonth.value = DateTime(
      currentMonth.value.year,
      currentMonth.value.month + delta,
    );
    selectedDate.value = DateTime(
      currentMonth.value.year,
      currentMonth.value.month,
      1,
    );

    animationController.forward();
    loadJournalEntry(uid);
  }

  void changeSelectedDate(DateTime date, String uid) {
    selectedDate.value = date;
    loadJournalEntry(uid);
  }

  Future<void> loadJournalEntry(String uid) async {
    isLoading.value = true;
    try {
      entries.clear();
      final entry = await _journalService.getJournalEntry(uid, selectedDate.value);
      if (entry != null) {
        entries.add(entry);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load journal entry', snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addOrUpdateJournalEntry(
      String uid, String title, String description) async {
    isLoading.value = true;
    try {
      await _journalService.addOrUpdateJournalEntry(
        uid,
        selectedDate.value,
        title,
        description,
      );
      await loadJournalEntry(uid);
    } catch (e) {
      Get.snackbar('Error', 'Failed to save journal entry', snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
