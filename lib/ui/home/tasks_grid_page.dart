import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/models/task.dart';
import 'package:habit_tracker_flutter/models/task_preset.dart';
import 'package:habit_tracker_flutter/ui/home/home_page_bottom_options.dart';
import 'package:habit_tracker_flutter/ui/home/tasks_grid.dart';

class TasksGridPage extends StatelessWidget {
  final List<Task> tasks;
  final VoidCallback? onFlip;
  const TasksGridPage({
    Key? key,
    required this.tasks,
    this.onFlip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: TasksGridContent(tasks: tasks, onFlip: onFlip));
  }
}

class TasksGridContent extends StatelessWidget {
  final List<Task> tasks;
  final VoidCallback? onFlip;
  const TasksGridContent({Key? key, required this.tasks, this.onFlip})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
            child: TasksGrid(
              tasks: tasks,
            ),
          ),
        ),
        HomePageBottomOptions(onFlip: onFlip)
      ],
    );
  }
}
