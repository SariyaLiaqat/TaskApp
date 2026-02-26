// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../viewmodels/task_viewmodel.dart';

// class StatsCard extends StatelessWidget {
//   const StatsCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final vm = context.watch<TaskViewModel>();
//     final double progress = vm.completionPercentage;

//     return Container(
//       margin: const EdgeInsets.all(16),
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         // Luxury dark-to-light blue gradient
//         gradient: LinearGradient(
//           colors: [Colors.blueAccent.shade700, Colors.blueAccent.shade400],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(30),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.blueAccent.withOpacity(0.3),
//             blurRadius: 20,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _statItem('Total Tasks', vm.tasks.length.toString(), Colors.white),
//               _statItem('Completed', vm.completedCount.toString(), Colors.white),
//               _statItem('Success Rate', '${(progress * 100).toInt()}%', Colors.white),
//             ],
//           ),
//           const SizedBox(height: 24),
//           // Interactive Progress Bar
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Overall Progress",
//                 style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 8),
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: LinearProgressIndicator(
//                   value: progress,
//                   minHeight: 10,
//                   backgroundColor: Colors.white24,
//                   valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _statItem(String label, String value, Color color) {
//     return Column(
//       children: [
//         Text(
//           value,
//           style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: color),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           label,
//           style: TextStyle(color: color.withOpacity(0.7), fontSize: 12, fontWeight: FontWeight.w500),
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
    
    // Calculating individual percentages for the rings
    final double totalTasks = vm.tasks.length.toDouble();
    final double doneTasks = vm.completedCount.toDouble();
    final double pendingTasks = totalTasks - doneTasks;

    // Avoid division by zero
    final double successProgress = totalTasks == 0 ? 0 : doneTasks / totalTasks;
    final double pendingProgress = totalTasks == 0 ? 0 : pendingTasks / totalTasks;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _circularStat(
            label: "Total",
            value: vm.tasks.length.toString(),
            progress: 1.0, // Always full circle for total
            color: Colors.blueAccent,
          ),
          _circularStat(
            label: "Done",
            value: vm.completedCount.toString(),
            progress: successProgress,
            color: Colors.greenAccent.shade700,
          ),
          _circularStat(
            label: "Pending",
            value: pendingTasks.toInt().toString(),
            progress: pendingProgress,
            color: Colors.orangeAccent,
          ),
        ],
      ),
    );
  }

  Widget _circularStat({
    required String label,
    required String value,
    required double progress,
    required Color color,
  }) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Background Track
            SizedBox(
              width: 85,
              height: 85,
              child: CircularProgressIndicator(
                value: 1.0,
                strokeWidth: 8,
                valueColor: AlwaysStoppedAnimation<Color>(color.withOpacity(0.1)),
              ),
            ),
            // Actual Progress
            SizedBox(
              width: 85,
              height: 85,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 8,
                strokeCap: StrokeCap.round, // Makes the ends of the progress rounded
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
            // The Number inside
            Text(
              value,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }
}