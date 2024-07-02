import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odoo_timer/bloc/create_timer_bloc/create_timer_bloc.dart';
import 'package:odoo_timer/bloc/task_detail_bloc/task_detail_bloc.dart';
import 'package:odoo_timer/bloc/tasks_bloc/tasks_bloc.dart';
import 'package:odoo_timer/screens/home_screen/home_screen.dart';
import 'package:odoo_timer/utils/theme.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TasksBloc()),
        BlocProvider(create: (_) => CreateTimerBloc()),
        BlocProvider(create: (_) => TaskDetailBloc())
      ],
      child: OverlaySupport.global(
        child: ResponsiveSizer(
          builder:(_, __, ___) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.theme,
            home: const HomeScreen(),
          ),
        ),
      ),
    );
  }
}

