import 'dart:math';

import 'package:flutter/material.dart';
import 'package:habit_tracker_flutter/constants/app_colors.dart';
import 'package:habit_tracker_flutter/models/app_theme_settings.dart';
import 'package:habit_tracker_flutter/ui/sliding_panel/theme_variant_picker.dart';

class ThemeSelectionList extends StatefulWidget {
  final AppThemeSettingsModel currentThemeSettingsModel;
  final double availableWidth;
  final ValueChanged<int>? onColorIndexSelected;
  final ValueChanged<int>? onVariantIndexSelected;
  
  const ThemeSelectionList({
    Key? key,
    required this.currentThemeSettingsModel,
    required this.availableWidth,
    this.onColorIndexSelected,
    this.onVariantIndexSelected,
  }) : super(key: key);

  @override
  _ThemeSelectionListState createState() => _ThemeSelectionListState();
}

class _ThemeSelectionListState extends State<ThemeSelectionList> {
  late final _controller = ScrollController(initialScrollOffset: scrollOffset);

  double get scrollOffset {
    final contentWidth =
        ThemeVariantPicker.itemSize * AppColors.allSwatches.length;
    final selectedIndex = widget.currentThemeSettingsModel.colorIndex;
    final offset = ThemeVariantPicker.itemSize * selectedIndex -
        (widget.availableWidth / 2 - ThemeVariantPicker.itemSize / 2);
    return max(min(offset, contentWidth - widget.availableWidth), 0);
  }

  @override
  Widget build(BuildContext context) {
    final allColors = AppColors.allSwatches.map((swatch) => swatch[0]).toList();
    return ListView(
      controller: _controller,
      scrollDirection: Axis.horizontal,
      children: [
        for (final color in allColors)
          ThemeVariantPicker(
            color: color,
            isSelected: widget.currentThemeSettingsModel.colorIndex ==
                allColors.indexOf(color),
            selectedVariantIndex: widget.currentThemeSettingsModel.variantIndex,
            onColorSelected: (color) {
              final newIndex = allColors.indexOf(color);
              final previousIndex = widget.currentThemeSettingsModel.colorIndex;
              if (previousIndex != newIndex) {
                widget.onColorIndexSelected?.call(allColors.indexOf(color));
              } else {
                final newVariantIndex =
                    (widget.currentThemeSettingsModel.variantIndex + 1) % 3;
                widget.onVariantIndexSelected?.call(newVariantIndex);
              }
            },
          ),
      ],
    );
  }
}
