import 'dart:math';

import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/models/task.dart';
import 'package:habit_tracker_flutter/ui/animations/animation_controller_state.dart';
import 'package:habit_tracker_flutter/ui/animations/cutom_fade_transition_widget.dart';
import 'package:habit_tracker_flutter/ui/animations/staggered_scale_transition_widget.dart';
import 'package:habit_tracker_flutter/ui/common_widgets/edit_task_button.dart';
import 'package:habit_tracker_flutter/ui/task/add_task_item.dart';
import 'package:habit_tracker_flutter/ui/task/task_with_name_loader.dart';

class TasksGrid extends StatefulWidget {
  final List<Task> tasks;
  const TasksGrid({Key? key, required this.tasks}) : super(key: key);

  @override
  State<TasksGrid> createState() => TasksGridState(Duration(milliseconds: 400));
}

class TasksGridState extends AnimationControllerState<TasksGrid> {
  TasksGridState(Duration duration) : super(duration);

  bool _isEditing = false;

  void enterEditMode() {
    animationController.forward();
    setState(() => _isEditing = true);
  }

  void exitEditMode() {
    animationController.reverse();
    setState(() => _isEditing = false);
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
        final length = min(6, widget.tasks.length + 1);
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: crossAxisSpacing,
              mainAxisSpacing: mainAxisSpacing,
              childAspectRatio: aspectRatio),
          itemCount: length,
          itemBuilder: (context, index) {
            if (index == widget.tasks.length) {
              return CustomFadeTransition(
                animation: animationController,
                child: AddTaskItem(
                  onCompleted: _isEditing ? () {} : null,
                ),
              );
            }
            final task = widget.tasks[index];
            return TaskWithNameLoader(
              task: task,
              isEditing: _isEditing,
              editTaskButtonBuilder: (_) => StaggeredScaleTransition(
                animation: animationController,
                index: index,
                child: EditTaskButton(),
              ),
            );
          },
        );
      },
    );
  }
}
