import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JournalController extends GetxController with GetTickerProviderStateMixin {
  final currentMonth = DateTime.now().obs;
  final selectedDate = DateTime.now().obs;

  late AnimationController animationController;
  late Animation<Offset> slideAnimation;

  final forward = true.obs;

  List<Map<String, String>> get entriesForSelectedDate {
    return List.generate(
      2,
          (i) => {
        'title': 'Entry ${i + 1}',
        'snippet': 'This is a snippet for entry ${i + 1} on ${selectedDate.value.day}.',
      },
    );
  }

  static const List<String> monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];

  String get monthLabel =>
      '${monthNames[currentMonth.value.month - 1]} ${currentMonth.value.year}';

  void initController(TickerProvider vsync) {
    animationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 400),
    );
    _setAnimation();
    animationController.forward();
  }

  void _setAnimation() {
    slideAnimation = Tween<Offset>(
      begin: Offset(forward.value ? 1 : -1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );
  }

  void changeMonth(int delta) {
    forward.value = delta > 0;
    _setAnimation();
    animationController.reset();
    currentMonth.value = DateTime(currentMonth.value.year, currentMonth.value.month + delta);
    selectedDate.value = DateTime(currentMonth.value.year, currentMonth.value.month, 1);
    animationController.forward();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
