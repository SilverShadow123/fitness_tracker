import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fitness_tracker/controllers/profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final ProfileController profileController = Get.find<ProfileController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Initializing the controllers for the text fields
    final TextEditingController nameController = TextEditingController();
    final TextEditingController ageController = TextEditingController();
    final TextEditingController weightController = TextEditingController();
    final TextEditingController heightController = TextEditingController();

    // Load user data when the screen is loaded
    Future<void> _loadUserData() async {
      await profileController.loadUserProfileData();
      nameController.text = profileController.name.value;
      ageController.text = profileController.age.value.toString();
      weightController.text = profileController.weight.value.toString();
      heightController.text = profileController.height.value.toString();
    }

    // Call _loadUserData when the screen is initialized
    _loadUserData();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Colors.blue.shade700,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Picture Placeholder
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue.shade100,
                    child: const Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Name Field
                _buildTextField(nameController, 'Name', TextInputType.text),
                const SizedBox(height: 12),

                // Age Field
                _buildTextField(ageController, 'Age', TextInputType.number),
                const SizedBox(height: 12),

                // Weight Field
                _buildTextField(
                  weightController,
                  'Weight (kg)',
                  TextInputType.number,
                ),
                const SizedBox(height: 12),

                // Height Field
                _buildTextField(
                  heightController,
                  'Height (cm)',
                  TextInputType.number,
                ),
                const SizedBox(height: 20),

                // Save Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Update profile in Firestore
                        profileController.updateProfileInFirestore(
                          newName: nameController.text,
                          newAge: int.parse(ageController.text),
                          newWeight: double.parse(weightController.text),
                          newHeight: double.parse(heightController.text),
                        );
                        Get.back(); // Go back to the previous screen
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12,
                      ),
                      backgroundColor: Colors.blue.shade800,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Save Changes',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
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

  // Reusable TextField Widget with decoration and validation
  Widget _buildTextField(
    TextEditingController controller,
    String label,
    TextInputType keyboardType,
  ) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.blue.shade50,
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.blue),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field cannot be empty';
          }
          return null;
        },
      ),
    );
  }
}
