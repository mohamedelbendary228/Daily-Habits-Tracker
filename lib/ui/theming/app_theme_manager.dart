import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/models/app_theme_settings.dart';
import 'package:habit_tracker_flutter/models/front_or_back_side.dart';
import 'package:habit_tracker_flutter/persistence/hive_data_store.dart';

class AppThemeManager extends StateNotifier<AppThemeSettingsModel> {
  final HiveDataStore dataStore;
  final FrontOrBackSide side;
  AppThemeManager({
    required AppThemeSettingsModel state,
    required this.dataStore,
    required this.side,
  }) : super(state);

  void updateColorIndex(int colorIndex) {
    state = state.copyWith(colorIndex: colorIndex);
    dataStore.setAppThemeSettings(settings: state, side: side);
  }

  void updateVariantIndex(int variantIndex) {
    state = state.copyWith(variantIndex: variantIndex);
    dataStore.setAppThemeSettings(settings: state, side: side);
  }
}
