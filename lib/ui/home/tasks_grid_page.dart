import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/models/task.dart';
import 'package:habit_tracker_flutter/models/task_preset.dart';
import 'package:habit_tracker_flutter/ui/home/tasks_grid.dart';

class TasksGridPage extends StatelessWidget {
  final List<Task> tasks;
  const TasksGridPage({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: TasksGridContent(tasks: tasks));
  }
}

class TasksGridContent extends StatelessWidget {
  final List<Task> tasks;
  const TasksGridContent({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
      child: TasksGrid(
        tasks: tasks,
      ),
    );
  }
}
