import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:odoo_timer/bloc/timesheet_bloc.dart';
import 'package:odoo_timer/utils/extensions.dart';

/// A custom navigation bar that implements the [PreferredSize] widget which is internally used
/// by default Flutter app bars for both Android and iOS
class HomePageNavBar extends StatelessWidget implements PreferredSize {
  const HomePageNavBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Timesheets",
                style: context.textTheme.headlineLarge,
              ),
              PlatformIconButton(
                  icon: const Icon(
                    Icons.add,
                    size: 24,
                  ),
                  onPressed: () {
                    context.read<TimesheetBloc>().add(AddTimesheetEvent());
                  })
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget get child => throw UnimplementedError();
}
