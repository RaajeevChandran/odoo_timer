import 'package:flutter/material.dart';
import 'package:odoo_timer/screens/widgets/home_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeNavBar(),
      body: Container()
    );
  }
}