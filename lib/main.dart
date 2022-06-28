import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker_flutter/constants/app_assets.dart';
import 'package:habit_tracker_flutter/models/front_or_back_side.dart';
import 'package:habit_tracker_flutter/persistence/hive_data_store.dart';
import 'package:habit_tracker_flutter/provider/providers.dart';
import 'package:habit_tracker_flutter/ui/onboarding/landing_page.dart';
import 'package:habit_tracker_flutter/ui/theming/app_theme_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppAssets.preloadSVGs();
  final dataStore = HiveDataStore();
  await dataStore.init();
   final frontThemeSettings =
      await dataStore.appThemeSettings(side: FrontOrBackSide.front);
  final backThemeSettings =
      await dataStore.appThemeSettings(side: FrontOrBackSide.back);

  runApp(
    ProviderScope(
      overrides: [
        dataStoreProvider.overrideWithValue(dataStore),
        frontThemeManagerProvider.overrideWithValue(
          AppThemeManager(
              state: frontThemeSettings,
              dataStore: dataStore,
              side: FrontOrBackSide.front),
        ),
        backThemeManagerProvider.overrideWithValue(
          AppThemeManager(
              state: backThemeSettings,
              dataStore: dataStore,
              side: FrontOrBackSide.back),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Helvetica Neue',
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      home: LandingPage(),
    );
  }
}
