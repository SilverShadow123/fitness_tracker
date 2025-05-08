import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Obx(
      () => BottomNavigationBar(
        currentIndex: controller.page.value,
        onTap: controller.onPageChanged,
        selectedItemColor: Colors.blue,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer_outlined),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'home',
          ),
        ],
      ),
    );
  }
}
