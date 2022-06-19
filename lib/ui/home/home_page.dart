import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/models/task.dart';
import 'package:habit_tracker_flutter/provider/providers.dart';
import 'package:habit_tracker_flutter/ui/home/page_flip_builder.dart';
import 'package:habit_tracker_flutter/ui/home/tasks_grid_page.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends ConsumerWidget {
  final _pageFlipKey = GlobalKey<PageFlipBuilderState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final datastore = ref.watch(dataStoreProvider);
    return Scaffold(
      backgroundColor: AppTheme.of(context).primary,
      body: PageFlipBuilder(
        key: _pageFlipKey,
        frontBuilder: (_) => ValueListenableBuilder(
          valueListenable: datastore.frontTasksListenable(),
          builder: (_, Box<Task> box, __) {
            return TasksGridPage(
              tasks: box.values.toList(),
              onFlip: () => _pageFlipKey.currentState?.flip(),
            );
          },
        ),
        backBuilder: (_) => ValueListenableBuilder(
          valueListenable: datastore.backTasksListenable(),
          builder: (_, Box<Task> box, __) {
            return TasksGridPage(
              tasks: box.values.toList(),
              onFlip: () => _pageFlipKey.currentState?.flip(),
            );
          },
        ),
      ),
    );
  }
}
