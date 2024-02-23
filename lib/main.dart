import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odoo_timer/bloc/create_timer_bloc/create_timer_bloc.dart';
import 'package:odoo_timer/bloc/timesheet_bloc/timesheet_bloc.dart';
import 'package:odoo_timer/screens/home_screen/home_screen.dart';
import 'package:odoo_timer/utils/theme.dart';
import 'package:overlay_support/overlay_support.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TimesheetBloc()),
        BlocProvider(create: (_) => CreateTimerBloc())
      ],
      child: OverlaySupport.global(
        child: MaterialApp(
          theme: AppTheme.theme,
          home: const HomeScreen(),
        ),
      ),
    );
  }
}

