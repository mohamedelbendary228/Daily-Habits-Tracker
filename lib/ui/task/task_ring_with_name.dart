import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/constants/text_styles.dart';
import 'package:habit_tracker_flutter/models/task.dart';
import 'package:habit_tracker_flutter/ui/task/animated_task.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

class TaskRingWithName extends StatelessWidget {
  final Task task;
  final bool completed;
  final ValueChanged<bool>? onCompleted;
  const TaskRingWithName({
    Key? key,
    required this.task,
    this.completed = false,
    this.onCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: AnimatedTaskRing(
            iconName: task.iconName,
            completed: completed,
            onCompleted: onCompleted,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          task.name.toUpperCase(),
          textAlign: TextAlign.center,
          overflow: task.name.length >= 40 ? TextOverflow.ellipsis : null,
          style: TextStyles.taskName.copyWith(
            color: AppTheme.of(context).accent,
          ),
        )
      ],
    );
  }
}
