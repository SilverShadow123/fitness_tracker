import 'dart:ui';

import 'package:flutter/material.dart';

class GoalCard extends StatelessWidget {
  const GoalCard({
    super.key,
    required this.context,
    required this.icon,
    required this.title,
    required this.target,
    required this.progress,
    required this.isExpanded,
    required this.onTap,
    required this.children,
  });

  final BuildContext context;
  final IconData icon;
  final String title;
  final String target;
  final double progress;
  final bool isExpanded;
  final VoidCallback onTap;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const baseColor = Color(0xFFE3F2FD);

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: 148,
          decoration: BoxDecoration(
            color: Colors.blue.shade100.withAlpha(80),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: baseColor.withAlpha(50), width: 1),
            boxShadow: [
              BoxShadow(
                color: baseColor.withAlpha(50),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  alignment: Alignment.topCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(icon, size: 24, color: const Color(0xFF1976D2)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              title,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: const Color(0xFF0D47A1),
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              target,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: const Color(0xFF0D47A1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: progress),
                        duration: const Duration(milliseconds: 800),
                        builder: (context, value, child) {
                          return Row(
                            children: [
                              Expanded(
                                child: LinearProgressIndicator(
                                  value: value,
                                  minHeight: 4,
                                  color: const Color(0xFF42A5F5),
                                  backgroundColor: baseColor.withAlpha(50),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${(value * 100).toInt()}%',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: const Color(0xFF0D47A1),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      ClipRect(
                        child: AnimatedCrossFade(
                          firstChild: const SizedBox.shrink(),
                          secondChild: Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                                  children
                                      .map(
                                        (child) => Padding(
                                          padding: const EdgeInsets.only(
                                            top: 4.0,
                                          ),
                                          child: AnimatedOpacity(
                                            opacity: isExpanded ? 1 : 0,
                                            duration: const Duration(
                                              milliseconds: 300,
                                            ),
                                            child: child,
                                          ),
                                        ),
                                      )
                                      .toList(),
                            ),
                          ),
                          crossFadeState:
                              isExpanded
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                          duration: const Duration(milliseconds: 300),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
