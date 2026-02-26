import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/task_viewmodel.dart';
import '../widgets/task_tile.dart';
import '../widgets/stats_card.dart';
import 'add_task_sheet.dart';

class HomeDesktop extends StatelessWidget {
  const HomeDesktop({super.key});

  void _openAddTask(BuildContext context) {
    // On desktop, we can use a Dialog instead of a BottomSheet for better UX
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: const SizedBox(width: 500, child: AddTaskSheet()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9), // Sophisticated Slate Grey
      body: Row(
        children: [
          // Navigation Sidebar
          const DesktopSidebar(),
          
          // Main Dashboard Area
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(40.0),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Workspace Overview',
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, letterSpacing: -1),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Manage your focus and track your daily milestones.',
                          style: TextStyle(color: Colors.blueGrey.shade400, fontSize: 16),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
                
                // Tasks List
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  sliver: Consumer<TaskViewModel>(
                    builder: (context, vm, _) {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, i) => ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 800),
                            child: TaskTile(task: vm.tasks[i]),
                          ),
                          childCount: vm.tasks.length,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.indigoAccent,
        onPressed: () => _openAddTask(context),
        label: const Text("Create New Task", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        icon: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class DesktopSidebar extends StatelessWidget {
  const DesktopSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(32.0),
            child: Row(
              children: [
                CircleAvatar(backgroundColor: Colors.blueAccent, child: Icon(Icons.bolt, color: Colors.white)),
                SizedBox(width: 12),
                Text("TaskFlow Pro", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const StatsCard(),
          const Spacer(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text("Settings"),
            onTap: () {},
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}