import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/constants/app_assets.dart';
import 'package:habit_tracker_flutter/models/task.dart';
import 'package:habit_tracker_flutter/ui/task/task_ring_with_name.dart';

class AddTaskItem extends StatelessWidget {
  const AddTaskItem({Key? key, this.onCompleted}) : super(key: key);
  final VoidCallback? onCompleted;

  @override
  Widget build(BuildContext context) {
    return TaskRingWithName(
      task: Task(
        id: '',
        name: 'Add a task',
        iconName: AppAssets.plus,
      ),
      completed: false,
      onCompleted: (completed) => onCompleted?.call(),
    );
  }
}
