import 'dart:ui';
import 'package:fitness_tracker/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';
import '../screens/edit_profile_screen.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const baseColor = Color(0xFFE3F2FD);
    final theme = Theme.of(context);
    final ProfileController profileController = Get.find<ProfileController>();

    Widget infoCard(IconData icon, String label, String value) {
      return Container(
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blue.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white70),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: theme.colorScheme.primary, size: 24),
            const SizedBox(height: 4),
            Text(label, style: theme.textTheme.bodySmall),
            const SizedBox(height: 2),
            Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: baseColor.withAlpha(200),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: baseColor.withAlpha(100), width: 2),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.blue.shade100.withAlpha(200),
                  child: const Icon(Icons.person, size: 40, color: Colors.black87),
                ),
                const SizedBox(height: 16),
                Obx(() => Text(
                  profileController.name.value,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                )),
                const SizedBox(height: 4),
                Obx(() => Text(
                  "${profileController.age.value} years old",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                )),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Obx(() => infoCard(
                      Icons.monitor_weight,
                      'Weight',
                      '${profileController.weight.value.toStringAsFixed(1)} kg',
                    )),
                    Obx(() => infoCard(
                      Icons.height,
                      'Height',
                      '${profileController.height.value.toStringAsFixed(0)} cm',
                    )),
                    Obx(() => infoCard(
                      Icons.health_and_safety,
                      'Status',
                      profileController.status.value,
                    )),
                    Obx(() => GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.history, arguments: profileController.uid.value);
                      },
                      child: infoCard(
                        Icons.history,
                        'History',
                        profileController.history.value,
                      ),
                    )),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    Get.to(() => EditProfileScreen()); // Navigate to EditProfileScreen
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text("Edit Profile"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
