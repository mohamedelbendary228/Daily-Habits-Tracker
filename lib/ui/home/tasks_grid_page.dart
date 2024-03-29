import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habit_tracker_flutter/models/app_theme_settings.dart';
import 'package:habit_tracker_flutter/models/task.dart';
import 'package:habit_tracker_flutter/ui/home/home_page_bottom_options.dart';
import 'package:habit_tracker_flutter/ui/home/tasks_grid.dart';
import 'package:habit_tracker_flutter/ui/sliding_panel/sliding_panel.dart';
import 'package:habit_tracker_flutter/ui/sliding_panel/sliding_panel_animator.dart';
import 'package:habit_tracker_flutter/ui/sliding_panel/theme_selection_close.dart';
import 'package:habit_tracker_flutter/ui/sliding_panel/theme_selection_list.dart';
import 'package:habit_tracker_flutter/ui/theming/animated_app_theme.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme.dart';

class TasksGridPage extends StatelessWidget {
  final List<Task> tasks;
  final VoidCallback? onFlip;
  final GlobalKey<SlidingPanelAnimatorState> leftAnimatorKey;
  final GlobalKey<SlidingPanelAnimatorState> rightAnimatorKey;
  final GlobalKey<TasksGridState> gridKey;
  final AppThemeSettingsModel appThemeSettings;
  final ValueChanged<int>? onColorIndexSelected;
  final ValueChanged<int>? onVariantIndexSelected;

  const TasksGridPage({
    Key? key,
    required this.tasks,
    required this.leftAnimatorKey,
    required this.rightAnimatorKey,
    required this.appThemeSettings,
    required this.gridKey,
    this.onColorIndexSelected,
    this.onVariantIndexSelected,
    this.onFlip,
  }) : super(key: key);

  void _enterEditMode() {
    leftAnimatorKey.currentState?.slidIn();
    rightAnimatorKey.currentState?.slidIn();
    gridKey.currentState?.enterEditMode();
  }

  void _exitEditMode() {
    leftAnimatorKey.currentState?.slidOut();
    rightAnimatorKey.currentState?.slidOut();
    gridKey.currentState?.exitEditMode();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedAppTheme(
      data: appThemeSettings.themeData,
      duration: Duration(milliseconds: 200),
      child: Builder(builder: (context) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: AppTheme.of(context).overlayStyle,
          child: Scaffold(
            backgroundColor: AppTheme.of(context).primary,
            body: SafeArea(
              child: Stack(
                children: [
                  TasksGridContents(
                    gridKey: gridKey,
                    tasks: tasks,
                    onFlip: onFlip,
                    onEnterEditMode: _enterEditMode,
                  ),
                  Positioned(
                    bottom: 6,
                    left: 0,
                    width: SlidingPanel.leftPanelFixedWidth,
                    child: SlidingPanelAnimator(
                      key: leftAnimatorKey,
                      direction: SlideDirection.leftToRight,
                      child: ThemeSelectionClose(onClose: _exitEditMode),
                    ),
                  ),
                  Positioned(
                    bottom: 6,
                    right: 0,
                    width: MediaQuery.of(context).size.width -
                        SlidingPanel.leftPanelFixedWidth,
                    child: SlidingPanelAnimator(
                      key: rightAnimatorKey,
                      direction: SlideDirection.rightToLeft,
                      child: ThemeSelectionList(
                        currentThemeSettingsModel: appThemeSettings,
                        onColorIndexSelected: onColorIndexSelected,
                        onVariantIndexSelected: onVariantIndexSelected,
                        availableWidth: MediaQuery.of(context).size.width -
                            SlidingPanel.leftPanelFixedWidth -
                            SlidingPanel.paddingWidth,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class TasksGridContents extends StatelessWidget {
  final List<Task> tasks;
  final VoidCallback? onFlip;
  final VoidCallback? onEnterEditMode;
  final GlobalKey<TasksGridState> gridKey;
  const TasksGridContents({
    Key? key,
    required this.tasks,
    required this.gridKey,
    this.onFlip,
    this.onEnterEditMode,
  }) : super(key: key);

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
              key: gridKey,
              tasks: tasks,
            ),
          ),
        ),
        HomePageBottomOptions(
          onFlip: onFlip,
          onEnterEditMode: onEnterEditMode,
        )
      ],
    );
  }
}
