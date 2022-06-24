import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/models/task.dart';
import 'package:habit_tracker_flutter/models/task_state.dart';
import 'package:habit_tracker_flutter/provider/providers.dart';
import 'package:habit_tracker_flutter/ui/task/task_ring_with_name.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TaskWithNameLoader extends ConsumerWidget {
  final Task task;
  final bool isEditing;
  final WidgetBuilder? editTaskButtonBuilder;
  const TaskWithNameLoader({
    Key? key,
    required this.task,
    this.isEditing = false,
    this.editTaskButtonBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataStore = ref.watch(dataStoreProvider);
    return ValueListenableBuilder(
      valueListenable: dataStore.taskStateListenable(task: task),
      builder: (_, Box<TaskState> box, __) {
        final taskState = dataStore.taskState(box, task: task);
        return TaskRingWithName(
          task: task,
          isEditing: isEditing,
          editTaskButtonBuilder: editTaskButtonBuilder,
          completed: taskState.completed,
          onCompleted: (completed) => ref
              .read(dataStoreProvider)
              .setTaskState(task: task, completed: completed),
        );
      },
    );
  }
}
