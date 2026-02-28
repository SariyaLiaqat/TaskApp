import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/task_viewmodel.dart';
import '../widgets/task_tile.dart';
import '../widgets/stats_card.dart';
import 'add_task_sheet.dart';

class HomeMobile extends StatelessWidget {
  const HomeMobile({super.key});

  // Opens the Add Task Bottom Sheet
  void _openAddTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddTaskSheet(),
    );
  }

  // Opens the Quick Actions Menu (Linked to the Grid Icon)
  void _showOptionsMenu(BuildContext context) {
    final viewModel = context.read<TaskViewModel>();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Pull Handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Quick Actions",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 20),
              
              // Action: Clear Completed
              ListTile(
                leading: const Icon(Icons.delete_sweep_rounded, color: Colors.redAccent),
                title: const Text("Clear Completed Tasks", style: TextStyle(fontWeight: FontWeight.w600)),
                onTap: () {
                  viewModel.clearCompletedTasks();
                  Navigator.pop(context);
                },
              ),
              
              // Action: Sort by Priority
              ListTile(
                leading: const Icon(Icons.sort_rounded, color: Color(0xFF4F46E5)),
                title: const Text("Sort by Priority", style: TextStyle(fontWeight: FontWeight.w600)),
                onTap: () {
                  viewModel.sortByPriority();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Dynamic top padding for notches/status bars
    final double topPadding = MediaQuery.of(context).padding.top + 20;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            'TaskFlow Pro',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF1E293B),
              fontSize: 24,
              letterSpacing: -1,
            ),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: IconButton(
              icon: const Icon(Icons.grid_view_rounded, size: 20, color: Color(0xFF4F46E5)),
              onPressed: () => _showOptionsMenu(context),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Responsive spacer that respects the status bar
          SizedBox(height: topPadding + kToolbarHeight),
          
          const StatsCard(),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Recent Tasks",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF334155),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Logic for View All can be added here later
                  },
                  style: TextButton.styleFrom(foregroundColor: const Color(0xFF4F46E5)),
                  child: const Text("View All", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),

          Expanded(
            child: Consumer<TaskViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.tasks.isEmpty) {
                  return _buildEmptyState();
                }
                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 100, top: 0),
                  itemCount: viewModel.tasks.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return TaskTile(task: viewModel.tasks[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF4F46E5),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        onPressed: () => _openAddTask(context),
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 32),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Color(0xFFEEF2FF),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.task_alt_rounded, 
              size: 60, 
              color: const Color(0xFF4F46E5).withOpacity(0.5)
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "No tasks yet!",
            style: TextStyle(
              color: Color(0xFF64748B),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Tap + to start your journey",
            style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
          ),
        ],
      ),
    );
  }
}