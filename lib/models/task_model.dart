
enum TaskPriority { low, medium, high }

class TaskModel {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime? dueDate;
  final TaskPriority priority;
  bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    this.description = '',
    required this.createdAt,
    this.dueDate,
    this.priority = TaskPriority.low,
    this.isCompleted = false,
  });

  // To toggle status easily
  void toggleCompleted() {
    isCompleted = !isCompleted;
  }
}