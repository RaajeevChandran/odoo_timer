import 'package:flutter/material.dart';
import 'package:odoo_timer/models/models.dart';
import 'package:odoo_timer/utils/utils.dart';

class ElapsedTimeWidget extends StatelessWidget {
  final Timesheet timesheet;
  final bool forTaskDetailPage;
  const ElapsedTimeWidget(
      {required this.timesheet, this.forTaskDetailPage = false, super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: timesheet.elapsedTimeStream,
      builder: (context, snapshot) {
        if (snapshot.hasData || snapshot.data == null) {
          return Text(
            snapshot.data == null ? timesheet.lastElapsedTime : snapshot.data!,
            style: forTaskDetailPage
                ? context.textTheme.displaySmall
                : context.textTheme.labelLarge?.copyWith(
                    color:
                        !timesheet.isRunning ? Colors.white : Colors.black),
          );
        }
        return const SizedBox();
      },
    );
  }
}
