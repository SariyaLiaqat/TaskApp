// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../models/task_model.dart';
// import '../../viewmodels/task_viewmodel.dart';

// class TaskTile extends StatelessWidget {
//   final TaskModel task;
//   const TaskTile({super.key, required this.task});

//   Color _getPriorityColor() {
//     switch (task.priority) {
//       case TaskPriority.high: return const Color(0xFFFF5252); // Vibrant Red
//       case TaskPriority.medium: return const Color(0xFFFFAB40); // Soft Orange
//       case TaskPriority.low: return const Color(0xFF4CAF50); // Material Green
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white, // 💡 FIX: Set to pure white
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.blueGrey.withOpacity(0.1), // Soft blue-grey shadow
//             blurRadius: 15,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: Container(
//           decoration: BoxDecoration(
//             border: Border(
//               left: BorderSide(color: _getPriorityColor(), width: 6),
//             ),
//           ),
//           child: ListTile(
//             contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             leading: Transform.scale(
//               scale: 1.3,
//               child: Checkbox(
//                 value: task.isCompleted,
//                 shape: const CircleBorder(),
//                 activeColor: _getPriorityColor(),
//                 side: BorderSide(color: Colors.grey.shade400, width: 1.5),
//                 onChanged: (_) => context.read<TaskViewModel>().toggleTaskStatus(task.id),
//               ),
//             ),
//             title: Text(
//               task.title,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//                 color: task.isCompleted ? Colors.grey.shade400 : Colors.blueGrey.shade900,
//                 decoration: task.isCompleted ? TextDecoration.lineThrough : null,
//               ),
//             ),
//             subtitle: Padding(
//               padding: const EdgeInsets.only(top: 6.0),
//               child: Row(
//                 children: [
//                   Icon(Icons.flag_rounded, size: 14, color: _getPriorityColor()),
//                   const SizedBox(width: 4),
//                   Text(
//                     task.priority.name.toUpperCase(),
//                     style: TextStyle(
//                       color: _getPriorityColor(),
//                       fontWeight: FontWeight.w800,
//                       letterSpacing: 0.5,
//                       fontSize: 11,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             trailing: IconButton(
//               icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
//               onPressed: () => context.read<TaskViewModel>().deleteTask(task.id),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }









import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/task_model.dart';
import '../../viewmodels/task_viewmodel.dart';

class TaskTile extends StatelessWidget {
  final TaskModel task;
  const TaskTile({super.key, required this.task});

  Color _getPriorityColor() {
    switch (task.priority) {
      case TaskPriority.high: return const Color(0xFFEF4444); // Modern Red
      case TaskPriority.medium: return const Color(0xFFF59E0B); // Modern Amber
      case TaskPriority.low: return const Color(0xFF10B981); // Modern Emerald
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: task.isCompleted ? 0.7 : 1.0,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          // Subtle border instead of heavy shadow for a "clean" look
          border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: InkWell( // Making the whole tile interactive
            onTap: () => context.read<TaskViewModel>().toggleTaskStatus(task.id),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  // 1. Custom Circular Toggle
                  Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: task.isCompleted ? _getPriorityColor() : Colors.transparent,
                      border: Border.all(
                        color: task.isCompleted ? _getPriorityColor() : const Color(0xFFCBD5E1),
                        width: 2,
                      ),
                    ),
                    child: task.isCompleted 
                      ? const Icon(Icons.check, size: 16, color: Colors.white) 
                      : null,
                  ),
                  const SizedBox(width: 16),
                  
                  // 2. Task Text Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: task.isCompleted ? const Color(0xFF94A3B8) : const Color(0xFF1E293B),
                            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Small Priority Tag
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getPriorityColor().withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            task.priority.name.toUpperCase(),
                            style: TextStyle(
                              color: _getPriorityColor(),
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 3. Simple Delete Action
                  IconButton(
                    icon: const Icon(Icons.delete_outline_rounded, color: Color(0xFFFDA4AF)),
                    onPressed: () => context.read<TaskViewModel>().deleteTask(task.id),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}