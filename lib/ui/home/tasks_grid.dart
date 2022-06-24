import 'dart:math';

import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/models/task.dart';
import 'package:habit_tracker_flutter/ui/animations/animation_controller_state.dart';
import 'package:habit_tracker_flutter/ui/animations/staggered_scale_animation_widget.dart';
import 'package:habit_tracker_flutter/ui/common_widgets/edit_task_button.dart';
import 'package:habit_tracker_flutter/ui/task/task_with_name_loader.dart';

class TasksGrid extends StatefulWidget {
  final List<Task> tasks;
  const TasksGrid({Key? key, required this.tasks}) : super(key: key);

  @override
  State<TasksGrid> createState() => TasksGridState(Duration(milliseconds: 300));
}

class TasksGridState extends AnimationControllerState<TasksGrid> {
  TasksGridState(Duration duration) : super(duration);

  void enterEditMode() {
    animationController.forward();
  }

  void exitEditMode() {
    animationController.reverse();
  }

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
          itemCount: widget.tasks.length,
          itemBuilder: (context, index) {
            final task = widget.tasks[index];
            return TaskWithNameLoader(
              task: task,
              isEditing: false,
              editTaskButtonBuilder: (_) => StaggeredScaleAnimatedWidget(
                  animation: animationController, child: EditTaskButton()),
            );
          },
        );
      },
    );
  }
}
