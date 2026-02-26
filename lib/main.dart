import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/task_viewmodel.dart';
import 'views/home/home_screen.dart';
import 'services/task_storage_service.dart';

void main() async {
  // 1. Ensure Flutter is ready for native calls
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Initialize Hive Service
  final storageService = TaskStorageService();
  await storageService.init();

  // 3. Create the ViewModel and load data
  final taskVM = TaskViewModel();
  await taskVM.loadFromDisk();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: taskVM),
      ],
      child: const TaskFlowApp(),
    ),
  );
}

class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaskFlow Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blueAccent,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: const HomeScreen(),
    );
  }
}