import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/constants/text_styles.dart';
import 'package:habit_tracker_flutter/models/task.dart';
import 'package:habit_tracker_flutter/ui/common_widgets/edit_task_button.dart';
import 'package:habit_tracker_flutter/ui/task/animated_task.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

class TaskRingWithName extends StatelessWidget {
  final Task task;
  final bool completed;
  final ValueChanged<bool>? onCompleted;
  final bool isEditing;
  final bool hasCompletedState;
  final WidgetBuilder? editTaskButtonBuilder;

  const TaskRingWithName({
    Key? key,
    required this.task,
    this.completed = false,
    this.isEditing = false,
    this.hasCompletedState = false,
    this.editTaskButtonBuilder,
    this.onCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Stack(
            children: [
              AnimatedTaskRing(
                iconName: task.iconName,
                completed: completed,
                isEditing: isEditing,
                onCompleted: onCompleted,
              ),
              if (editTaskButtonBuilder != null)
                Positioned.fill(
                  child: FractionallySizedBox(
                    widthFactor: EditTaskButton.scaleFactor,
                    heightFactor: EditTaskButton.scaleFactor,
                    alignment: Alignment.bottomRight,
                    child: editTaskButtonBuilder!(context),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: 40,
          child: Text(
            task.name.toUpperCase(),
            maxLines: 2,
            textAlign: TextAlign.center,
            //overflow: task.name.length >= 40 ? TextOverflow.ellipsis : null,
            style: TextStyles.taskName.copyWith(
              color: AppTheme.of(context).accent,
            ),
          ),
        )
      ],
    );
  }
}
