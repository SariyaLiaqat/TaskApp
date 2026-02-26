import 'package:flutter/material.dart';
import 'home_mobile.dart';
import 'home_tablet.dart';
import 'home_desktop.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 1200) {
            return const HomeDesktop(); // Laptop/Desktop view
          } else if (constraints.maxWidth > 600) {
            return const HomeTablet();  // Tablet view
          } else {
            return const HomeMobile();  // Phone view
          }
        },
      ),
    );
  }
}