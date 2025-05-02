import 'dart:ui';
import 'package:fitness_tracker/widgets/add_journal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

import '../controllers/journal_controller.dart';

class JournalWidget extends StatefulWidget {
  const JournalWidget({super.key});

  @override
  _JournalWidgetState createState() => _JournalWidgetState();
}

class _JournalWidgetState extends State<JournalWidget> with TickerProviderStateMixin {
  final controller = Get.put(JournalController());

  @override
  void initState() {
    super.initState();
    controller.initController(this);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const baseColor = Color(0xFFE3F2FD);

    return Obx(() {
      final firstDay = DateTime(controller.currentMonth.value.year, controller.currentMonth.value.month, 1);
      final lastDay = DateTime(controller.currentMonth.value.year, controller.currentMonth.value.month + 1, 0);

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
                Text('Journal', style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 32

                )
                ),
                const SizedBox(height: 12),
                // Month Navigation
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      color: Colors.blue[800],
                      onPressed: () => controller.changeMonth(-1),
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
                      onPressed: () => controller.changeMonth(1),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // EasyDateTimeLinePicker
                EasyTheme(
                  data: EasyTheme.of(context).copyWith(
                    dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) return Colors.blue.shade800;
                      if (states.contains(WidgetState.disabled)) return Colors.grey.shade100;
                      if (states.contains(WidgetState.focused)) return Colors.blue.shade200;
                      return Colors.white;
                    }),
                  ),
                  child: EasyDateTimeLinePicker(
                    firstDate: firstDay,
                    lastDate: lastDay,
                    focusedDate: controller.selectedDate.value,
                    onDateChange: (date) => controller.selectedDate.value = date,
                  ),
                ),

                const SizedBox(height: 12),
                // Journal Entries
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.entriesForSelectedDate.length,
                    itemBuilder: (context, i) {
                      final entry = controller.entriesForSelectedDate[i];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: baseColor,
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          title: Text(entry['title']!, style: TextStyle(color: Colors.blue[900])),
                          subtitle: Text(entry['snippet']!, style: TextStyle(color: Colors.blueGrey[800])),
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    mini: true,
                    backgroundColor: Colors.blue[600],
                    onPressed: () {
                      // Add entry
                     showDialog(context: context, builder: (context) => AddJournal());
                    },
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
