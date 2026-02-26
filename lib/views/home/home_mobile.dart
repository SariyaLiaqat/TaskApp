import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/task_viewmodel.dart';
import '../widgets/task_tile.dart';
import '../widgets/stats_card.dart';
import 'add_task_sheet.dart';

class HomeMobile extends StatelessWidget {
  const HomeMobile({super.key});

  void _openAddTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddTaskSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('TaskFlow Pro', 
          style: TextStyle(fontWeight: FontWeight.w900, color: Colors.black87)),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.grid_view_rounded, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC), // Ultra light designer grey
        ),
        child: Column(
          children: [
            const SizedBox(height: 100), // Space for Transparent AppBar
            const StatsCard(),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Recent Tasks", 
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                  TextButton(onPressed: () {}, child: const Text("View All")),
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
                    padding: const EdgeInsets.only(bottom: 100), // Space for FAB
                    itemCount: viewModel.tasks.length,
                    itemBuilder: (context, index) {
                      return TaskTile(task: viewModel.tasks[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
     // Change this line:
floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // <--- Change to endFloat
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blueAccent,
        onPressed: () => _openAddTask(context),
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: const Text("Create New Task", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.task_alt_rounded, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text("No tasks yet!", 
            style: TextStyle(color: Colors.grey.shade500, fontSize: 16, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}