import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/task_viewmodel.dart';
import '../widgets/task_tile.dart';
import '../widgets/stats_card.dart';
import 'add_task_sheet.dart';

class HomeTablet extends StatelessWidget {
  const HomeTablet({super.key});

  void _openAddTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80.0), // Center it on tablet
        child: const AddTaskSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('TaskFlow Pro • Tablet', 
          style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Row(
        children: [
          // Sidebar-lite for Tablet
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: StatsCard(),
                  ),
                  _buildQuickAction(Icons.star_outline, "Starred Tasks"),
                  _buildQuickAction(Icons.calendar_month_outlined, "Calendar View"),
                  _buildQuickAction(Icons.archive_outlined, "Archived"),
                ],
              ),
            ),
          ),
          
          const VerticalDivider(width: 1),

          // Main Task Content
          Expanded(
            flex: 3,
            child: Consumer<TaskViewModel>(
              builder: (context, viewModel, child) {
                return ListView.builder(
                  padding: const EdgeInsets.all(24),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddTask(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      onTap: () {},
    );
  }
}