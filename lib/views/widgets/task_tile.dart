import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/task_model.dart';
import '../../viewmodels/task_viewmodel.dart';

class TaskTile extends StatelessWidget {
  final TaskModel task;
  const TaskTile({super.key, required this.task});

  Color _getPriorityColor() {
    switch (task.priority) {
      case TaskPriority.high: return const Color(0xFFFF5252); // Vibrant Red
      case TaskPriority.medium: return const Color(0xFFFFAB40); // Soft Orange
      case TaskPriority.low: return const Color(0xFF4CAF50); // Material Green
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white, // 💡 FIX: Set to pure white
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.1), // Soft blue-grey shadow
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: _getPriorityColor(), width: 6),
            ),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            leading: Transform.scale(
              scale: 1.3,
              child: Checkbox(
                value: task.isCompleted,
                shape: const CircleBorder(),
                activeColor: _getPriorityColor(),
                side: BorderSide(color: Colors.grey.shade400, width: 1.5),
                onChanged: (_) => context.read<TaskViewModel>().toggleTaskStatus(task.id),
              ),
            ),
            title: Text(
              task.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: task.isCompleted ? Colors.grey.shade400 : Colors.blueGrey.shade900,
                decoration: task.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: Row(
                children: [
                  Icon(Icons.flag_rounded, size: 14, color: _getPriorityColor()),
                  const SizedBox(width: 4),
                  Text(
                    task.priority.name.toUpperCase(),
                    style: TextStyle(
                      color: _getPriorityColor(),
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
              onPressed: () => context.read<TaskViewModel>().deleteTask(task.id),
            ),
          ),
        ),
      ),
    );
  }
}