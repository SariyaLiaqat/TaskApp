import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/task_storage_service.dart';

class TaskViewModel extends ChangeNotifier {
  final List<TaskModel> _tasks = [];
  final TaskStorageService _storage = TaskStorageService();
  String _searchQuery = '';

  // Getters
  List<TaskModel> get tasks {
    if (_searchQuery.isEmpty) return _tasks;
    return _tasks
        .where((t) => t.title.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  // --- Load Data ---
  Future<void> loadFromDisk() async {
    final storedData = _storage.loadTasks();
    _tasks.clear();

    for (var item in storedData) {
      _tasks.add(TaskModel(
        id: item['id'],
        title: item['title'],
        isCompleted: item['isCompleted'],
        priority: TaskPriority.values[item['priority']], 
        createdAt: DateTime.now(),
      ));
    }
    notifyListeners();
  }

  // --- NEW: Clear Completed ---
  void clearCompletedTasks() {
    _tasks.removeWhere((t) => t.isCompleted);
    _storage.saveTasks(_tasks); // Persist change
    notifyListeners();
  }

  // --- NEW: Sort by Priority ---
  void sortByPriority() {
    // Sorts: High -> Medium -> Low based on Enum index
    _tasks.sort((a, b) => a.priority.index.compareTo(b.priority.index));
    _storage.saveTasks(_tasks); // Persist change
    notifyListeners();
  }

  // --- Logic: Add ---
  void addTask(String title, TaskPriority priority) {
    final newTask = TaskModel(
      id: DateTime.now().toString(),
      title: title,
      createdAt: DateTime.now(),
      priority: priority,
    );
    _tasks.add(newTask);
    _storage.saveTasks(_tasks); 
    notifyListeners();
  }

  // --- Logic: Toggle Status ---
  void toggleTaskStatus(String id) {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index != -1) {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
      _storage.saveTasks(_tasks); 
      notifyListeners();
    }
  }

  // --- Logic: Delete ---
  void deleteTask(String id) {
    _tasks.removeWhere((t) => t.id == id);
    _storage.saveTasks(_tasks); 
    notifyListeners();
  }

  // Stats Logic
  int get completedCount => _tasks.where((t) => t.isCompleted).length;
  double get completionPercentage => 
      _tasks.isEmpty ? 0 : (completedCount / _tasks.length);
}