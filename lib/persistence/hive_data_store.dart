import 'package:habit_tracker_flutter/models/task.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDataStore {
  static const tasksBoxName = 'task';
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter<Task>(TaskAdapter());
    await Hive.openBox<Task>(tasksBoxName);
  }
}
