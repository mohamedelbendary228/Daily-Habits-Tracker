import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/models/app_theme_settings.dart';
import 'package:habit_tracker_flutter/models/task.dart';
import 'package:habit_tracker_flutter/provider/providers.dart';
import 'package:habit_tracker_flutter/ui/home/tasks_grid.dart';
import 'package:habit_tracker_flutter/ui/home/tasks_grid_page.dart';
import 'package:habit_tracker_flutter/ui/sliding_panel/sliding_panel_animator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:page_flip_builder/page_flip_builder.dart';

import '../../models/front_or_back_side.dart';

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
  final gridKey = GlobalKey<TasksGridState>();
  // final _backGridKey = GlobalKey<TasksGridState>();

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, __) {
        final datastore = ref.watch(dataStoreProvider);
        final frontProvider = ref.watch(frontThemeManagerProvider);
        final backProvider = ref.watch(backThemeManagerProvider);
        return PageFlipBuilder(
          key: _pageFlipKey,
          frontBuilder: (_) => ProviderScope(
            overrides: [
              frontOrBackSideProvider.overrideWithValue(FrontOrBackSide.front)
            ],
            child: ValueListenableBuilder(
              valueListenable: datastore.frontTasksListenable(),
              builder: (_, Box<Task> box, __) {
                return TasksGridPage(
                  key: ValueKey(1),
                  gridKey: gridKey,
                  appThemeSettings: frontProvider,
                  onColorIndexSelected: (colorIndex) => ref
                      .read(frontThemeManagerProvider.notifier)
                      .updateColorIndex(colorIndex),
                  onVariantIndexSelected: (variantIndex) => ref
                      .read(frontThemeManagerProvider.notifier)
                      .updateVariantIndex(variantIndex),
                  leftAnimatorKey: _frontSlidingPanelLeftAnimatorKey,
                  rightAnimatorKey: _frontSlidingPanelRightAnimatorKey,
                  tasks: box.values.toList(),
                  onFlip: () => _pageFlipKey.currentState?.flip(),
                );
              },
            ),
          ),
          backBuilder: (_) => ProviderScope(
            overrides: [
              frontOrBackSideProvider.overrideWithValue(FrontOrBackSide.back)
            ],
            child: ValueListenableBuilder(
              valueListenable: datastore.backTasksListenable(),
              builder: (_, Box<Task> box, __) {
                return TasksGridPage(
                  key: ValueKey(2),
                  gridKey: gridKey,
                  appThemeSettings: backProvider,
                  onColorIndexSelected: (colorIndex) => ref
                      .read(backThemeManagerProvider.notifier)
                      .updateColorIndex(colorIndex),
                  onVariantIndexSelected: (variantIndex) => ref
                      .read(backThemeManagerProvider.notifier)
                      .updateVariantIndex(variantIndex),
                  leftAnimatorKey: _backSlidingPanelLeftAnimatorKey,
                  rightAnimatorKey: _backSlidingPanelRightAnimatorKey,
                  tasks: box.values.toList(),
                  onFlip: () => _pageFlipKey.currentState?.flip(),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
