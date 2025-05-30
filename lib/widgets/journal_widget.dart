import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import '../controllers/journal_controller.dart';
import 'add_journal.dart';

class JournalWidget extends StatefulWidget {
  final String uid;
  const JournalWidget({super.key, required this.uid});

  @override
  _JournalWidgetState createState() => _JournalWidgetState();
}

class _JournalWidgetState extends State<JournalWidget>
    with TickerProviderStateMixin {
  late final JournalController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(JournalController());
    controller.initController(this, widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const baseColor = Color(0xFFE3F2FD);

    return Obx(() {
      final firstDay = DateTime(
        controller.currentMonth.value.year,
        controller.currentMonth.value.month,
        1,
      );
      final lastDay = DateTime(
        controller.currentMonth.value.year,
        controller.currentMonth.value.month + 1,
        0,
      );

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
            child: Column(
              children: [
                Text(
                  'Journal',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 12),

                // Month Navigation
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      color: Colors.blue[800],
                      onPressed: () => controller.changeMonth(-1, widget.uid),
                    ),
                    Expanded(
                      child: SlideTransition(
                        position: controller.slideAnimation,
                        child: Text(
                          controller.monthLabel,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios),
                      color: Colors.blue[800],
                      onPressed: () => controller.changeMonth(1, widget.uid),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Date Timeline Picker
                EasyTheme(
                  data: EasyTheme.of(context).copyWith(
                    dayBackgroundColor: WidgetStateProperty.resolveWith((
                      states,
                    ) {
                      if (states.contains(WidgetState.selected)) {
                        return Colors.blue.shade800;
                      }
                      if (states.contains(WidgetState.disabled)) {
                        return Colors.grey.shade100;
                      }
                      if (states.contains(WidgetState.focused)) {
                        return Colors.blue.shade200;
                      }
                      return Colors.white;
                    }),
                  ),
                  child: EasyDateTimeLinePicker(
                    firstDate: firstDay,
                    lastDate: lastDay,
                    focusedDate: controller.selectedDate.value,
                    onDateChange:
                        (date) =>
                            controller.changeSelectedDate(date, widget.uid),
                  ),
                ),

                const SizedBox(height: 12),

                // Loading or Entries
                Expanded(
                  child:
                      controller.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : controller.entries.isEmpty
                          ? const Center(child: Text('No entry for this date.'))
                          : ListView.builder(
                            itemCount: controller.entries.length,
                            itemBuilder: (context, i) {
                              final entry = controller.entries[i];
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                color: baseColor,
                                elevation: 3,
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                child: ListTile(
                                  title: Text(
                                    entry['title'] ?? 'Untitled',
                                    style: TextStyle(color: Colors.blue[900]),
                                  ),
                                  subtitle: Text(
                                    entry['description'] ?? 'No Description',
                                    style: TextStyle(
                                      color: Colors.blueGrey[800],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                ),

                // Add Button
                Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    mini: true,
                    backgroundColor: Colors.blue[600],
                    onPressed:
                        () => showDialog(
                          context: context,
                          builder: (_) => AddJournal(uid: widget.uid),
                        ),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
