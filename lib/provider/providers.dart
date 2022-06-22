import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/models/app_theme_settings.dart';
import 'package:habit_tracker_flutter/persistence/hive_data_store.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme_manager.dart';

final dataStoreProvider = Provider<HiveDataStore>((ref) {
  throw UnimplementedError();
});

final frontThemeManagerProvider =
    StateNotifierProvider<AppThemeManager, AppThemeSettings>((ref) {
  throw UnimplementedError();
});

final backThemeManagerProvider =
    StateNotifierProvider<AppThemeManager, AppThemeSettings>((ref) {
  throw UnimplementedError();
});
