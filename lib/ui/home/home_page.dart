import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/models/task.dart';
import 'package:habit_tracker_flutter/provider/providers.dart';
import 'package:habit_tracker_flutter/ui/home/page_flip_builder.dart';
import 'package:habit_tracker_flutter/ui/home/tasks_grid_page.dart';
import 'package:habit_tracker_flutter/ui/sliding_panel/sliding_panel_animator.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageFlipKey = GlobalKey<PageFlipBuilderState>();
  final _frontSlidingPanelLeftAnimatorKey =
      GlobalKey<SlidingPanelAnimatorState>();
  final _frontSlidingPanelRightAnimatorKey =
      GlobalKey<SlidingPanelAnimatorState>();
  final _backSlidingPanelLeftAnimatorKey =
      GlobalKey<SlidingPanelAnimatorState>();
  final _backSlidingPanelRightAnimatorKey =
      GlobalKey<SlidingPanelAnimatorState>();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, __) {
        final datastore = ref.watch(dataStoreProvider);
        return PageFlipBuilder(
          key: _pageFlipKey,
          frontBuilder: (_) => ValueListenableBuilder(
            valueListenable: datastore.frontTasksListenable(),
            builder: (_, Box<Task> box, __) {
              return TasksGridPage(
                key: ValueKey(1),
                leftAnimatorKey: _frontSlidingPanelLeftAnimatorKey,
                rightAnimatorKey: _frontSlidingPanelRightAnimatorKey,
                tasks: box.values.toList(),
                onFlip: () => _pageFlipKey.currentState?.flip(),
              );
            },
          ),
          backBuilder: (_) => ValueListenableBuilder(
            valueListenable: datastore.backTasksListenable(),
            builder: (_, Box<Task> box, __) {
              return TasksGridPage(
                key: ValueKey(2),
                leftAnimatorKey: _backSlidingPanelLeftAnimatorKey,
                rightAnimatorKey: _backSlidingPanelRightAnimatorKey,
                tasks: box.values.toList(),
                onFlip: () => _pageFlipKey.currentState?.flip(),
              );
            },
          ),
        );
      },
    );
  }
}
