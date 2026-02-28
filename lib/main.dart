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
        // The core professional palette
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4F46E5),
          primary: const Color(0xFF4F46E5),
          surface: const Color(0xFFF8FAFC), // Ultra light background
        ),
        // Setting the default scaffold background
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        
        // Global Text Styling
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.w900,
            letterSpacing: -1,
          ),
        ),

        // Cleaning up the Global AppBar Theme
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          iconTheme: IconThemeData(color: Color(0xFF1E293B)),
        ),

        // Styling the Checkbox to match our Tiles
        checkboxTheme: CheckboxThemeData(
          shape: const CircleBorder(),
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) return const Color(0xFF4F46E5);
            return Colors.transparent;
          }),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}