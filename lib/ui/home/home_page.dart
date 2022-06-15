import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/constants/app_assets.dart';
import 'package:habit_tracker_flutter/models/task.dart';
import 'package:habit_tracker_flutter/models/task_preset.dart';
import 'package:habit_tracker_flutter/persistence/hive_data_store.dart';
import 'package:habit_tracker_flutter/ui/home/tasks_grid_page.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final datastore = HiveDataStore();

    return Scaffold(
      backgroundColor: AppTheme.of(context).primary,
      body: ValueListenableBuilder(
        valueListenable: datastore.taskListenable(),
        builder: (_, Box<Task> box, __) {
          return TasksGridPage(
            tasks: box.values.toList(),
          );
        },
      ),
    );
  }
}
