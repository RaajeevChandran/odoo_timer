import 'package:flutter/material.dart';
import 'package:odoo_timer/screens/home_screen.dart';
import 'package:odoo_timer/utils/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.theme,
      home: const HomeScreen(),
    );
  }
}

