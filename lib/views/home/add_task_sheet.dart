import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/task_model.dart';
import '../../viewmodels/task_viewmodel.dart';

class AddTaskSheet extends StatefulWidget {
  const AddTaskSheet({super.key});

  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  final _controller = TextEditingController();
  TaskPriority _selectedPriority = TaskPriority.low;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        left: 24,
        right: 24,
        top: 12,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag Handle
          Center(
            child: Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "New Milestone",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: -0.5),
          ),
          const SizedBox(height: 16),
          
          // Stylized Input
         // Updated Stylized Input
          TextField(
            controller: _controller,
            autofocus: true,
            // 💡 FIX: Force a dark color for the text you are typing
            style: const TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.w600, 
              color: Colors.black87, // High contrast black
            ),
            decoration: InputDecoration(
              hintText: 'What needs to be done?',
              hintStyle: TextStyle(color: Colors.grey[500]), // Slightly darker hint
              filled: true,
              fillColor: Colors.grey[100], // Light grey background
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              // Optional: Add a subtle border when active
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.blueAccent, width: 1),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            ),
          ),
          const SizedBox(height: 24),
          
          const Text("Select Priority", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 12),
          
          // Modern Segmented Selector
          SizedBox(
            width: double.infinity,
            child: SegmentedButton<TaskPriority>(
              style: SegmentedButton.styleFrom(
                selectedBackgroundColor: Colors.blueAccent,
                selectedForegroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              segments: const [
                ButtonSegment(value: TaskPriority.low, label: Text('Low'), icon: Icon(Icons.circle, size: 10, color: Colors.greenAccent)),
                ButtonSegment(value: TaskPriority.medium, label: Text('Med'), icon: Icon(Icons.circle, size: 10, color: Colors.orangeAccent)),
                ButtonSegment(value: TaskPriority.high, label: Text('High'), icon: Icon(Icons.circle, size: 10, color: Colors.redAccent)),
              ],
              selected: {_selectedPriority},
              onSelectionChanged: (set) => setState(() => _selectedPriority = set.first),
            ),
          ),
          const SizedBox(height: 32),
          
          // Gradient Action Button
          Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Colors.blueAccent, Colors.indigoAccent]),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(0.4),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                )
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  context.read<TaskViewModel>().addTask(_controller.text, _selectedPriority);
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              ),
              child: const Text(
                'Add to Schedule',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}