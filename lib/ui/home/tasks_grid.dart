import 'dart:math';

import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/models/task.dart';
import 'package:habit_tracker_flutter/models/task_preset.dart';
import 'package:habit_tracker_flutter/ui/task/task_ring_with_name.dart';

class TasksGrid extends StatelessWidget {
  final List<Task> tasks;
  const TasksGrid({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisSpacing = constraints.maxWidth * 0.05;
        final taskWidth = (constraints.maxWidth - crossAxisSpacing) / 2.0;
        const aspectRatio = 0.65;
        final taskHeight = taskWidth / aspectRatio;
        final mainAxisSpacing =
            max((constraints.maxHeight - taskHeight * 3.3) / 2.0, 0.1);

        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: crossAxisSpacing,
              mainAxisSpacing: mainAxisSpacing,
              childAspectRatio: aspectRatio),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return TaskRingWithName(
              task: task,
            );
          },
        );
      },
    );
  }
}
