import 'package:flutter/material.dart';
import '../widgets/daily_goals_history_widget.dart';

class HistoryScreen extends StatelessWidget {
  final String uid;

  const HistoryScreen({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goals History'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DailyGoalsHistoryWidget(uid: uid),
      ),
    );
  }
}
