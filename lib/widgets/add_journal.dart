import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/journal_controller.dart';

class AddJournal extends StatefulWidget {
  final String uid;
  const AddJournal({super.key, required this.uid});

  @override
  _AddJournalState createState() => _AddJournalState();
}

class _AddJournalState extends State<AddJournal> {
  static const Color bgColor = Color(0xFFE3F2FD);

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  late final JournalController journalController;

  @override
  void initState() {
    super.initState();
    journalController = Get.find<JournalController>();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.6,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.shade100.withAlpha(50),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Add Journal Entry',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: titleController,
                label: 'Entry Title',
                icon: Icons.title,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: descriptionController,
                label: 'Description',
                icon: Icons.description,
                maxLines: 5,
                maxLength: 200,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _saveJournalEntry,
                icon: const Icon(Icons.check, color: Colors.white),
                label: const Text(
                  'Save',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveJournalEntry() async {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();

    if (title.isEmpty || description.isEmpty) {
      Get.snackbar(
        'Error',
        'Title and description cannot be empty',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      await journalController.addOrUpdateJournalEntry(
        widget.uid,
        title,
        description,
      );
      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save journal entry',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    int? maxLength,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.blue),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(icon, color: Colors.blue.shade700),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue.shade700),
        ),
      ),
      keyboardType: maxLines > 1 ? TextInputType.multiline : TextInputType.text,
    );
  }
}
