import 'package:hive_flutter/hive_flutter.dart';
import '../models/task_model.dart';

class TaskStorageService {
  static const String _boxName = 'tasksBox';

  // Initialize Hive
  Future<void> init() async {
    await Hive.initFlutter();
    // In a real app, you'd register an Adapter here for TaskModel
    await Hive.openBox(_boxName);
  }

  // Save Task
  void saveTasks(List<TaskModel> tasks) {
    final box = Hive.box(_boxName);
    // Convert tasks to a format Hive understands (like a List of Maps)
    final data = tasks.map((t) => {
      'id': t.id,
      'title': t.title,
      'isCompleted': t.isCompleted,
      'priority': t.priority.index,
    }).toList();
    
    box.put('my_tasks', data);
  }

  // Load Tasks
  List<dynamic> loadTasks() {
    final box = Hive.box(_boxName);
    return box.get('my_tasks', defaultValue: []);
  }
}