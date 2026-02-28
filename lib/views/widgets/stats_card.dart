



// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../viewmodels/task_viewmodel.dart';

// class StatsCard extends StatelessWidget {
//   const StatsCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final vm = context.watch<TaskViewModel>();
    
//     // Calculating individual percentages for the rings
//     final double totalTasks = vm.tasks.length.toDouble();
//     final double doneTasks = vm.completedCount.toDouble();
//     final double pendingTasks = totalTasks - doneTasks;

//     // Avoid division by zero
//     final double successProgress = totalTasks == 0 ? 0 : doneTasks / totalTasks;
//     final double pendingProgress = totalTasks == 0 ? 0 : pendingTasks / totalTasks;

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 20),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           _circularStat(
//             label: "Total",
//             value: vm.tasks.length.toString(),
//             progress: 1.0, // Always full circle for total
//             color: Colors.blueAccent,
//           ),
//           _circularStat(
//             label: "Done",
//             value: vm.completedCount.toString(),
//             progress: successProgress,
//             color: Colors.greenAccent.shade700,
//           ),
//           _circularStat(
//             label: "Pending",
//             value: pendingTasks.toInt().toString(),
//             progress: pendingProgress,
//             color: Colors.orangeAccent,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _circularStat({
//     required String label,
//     required String value,
//     required double progress,
//     required Color color,
//   }) {
//     return Column(
//       children: [
//         Stack(
//           alignment: Alignment.center,
//           children: [
//             // Background Track
//             SizedBox(
//               width: 85,
//               height: 85,
//               child: CircularProgressIndicator(
//                 value: 1.0,
//                 strokeWidth: 8,
//                 valueColor: AlwaysStoppedAnimation<Color>(color.withOpacity(0.1)),
//               ),
//             ),
//             // Actual Progress
//             SizedBox(
//               width: 85,
//               height: 85,
//               child: CircularProgressIndicator(
//                 value: progress,
//                 strokeWidth: 8,
//                 strokeCap: StrokeCap.round, // Makes the ends of the progress rounded
//                 valueColor: AlwaysStoppedAnimation<Color>(color),
//               ),
//             ),
//             // The Number inside
//             Text(
//               value,
//               style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 13,
//             fontWeight: FontWeight.bold,
//             color: Colors.blueGrey,
//           ),
//         ),
//       ],
//     );
//   }
// }







import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/task_viewmodel.dart';

class StatsCard extends StatelessWidget {
  const StatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TaskViewModel>();
    
    final int totalTasks = vm.tasks.length;
    final int doneTasks = vm.completedCount;
    final int pendingTasks = totalTasks - doneTasks;
    final double successProgress = totalTasks == 0 ? 0 : doneTasks / totalTasks;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        // Using a sophisticated Deep Indigo gradient
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4F46E5), Color(0xFF6366F1)], 
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4F46E5).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left Side: Main Progress Circle
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 75,
                height: 75,
                child: CircularProgressIndicator(
                  value: successProgress,
                  strokeWidth: 8,
                  strokeCap: StrokeCap.round,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              Text(
                "${(successProgress * 100).toInt()}%",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(width: 24),
          
          // Right Side: Stats Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Great Job!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  "You've completed $doneTasks tasks today",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _smallStatItem("Total", totalTasks.toString()),
                    const SizedBox(width: 20),
                    _smallStatItem("Pending", pendingTasks.toString()),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _smallStatItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}