import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odoo_timer/bloc/task_detail_bloc/task_detail_bloc.dart';
import 'package:odoo_timer/screens/task_detail_screen/widgets/active_timesheet_card.dart';
import 'package:odoo_timer/screens/task_detail_screen/widgets/completed_timesheet_card.dart';
import 'package:odoo_timer/utils/utils.dart';

import '../../../models/timesheet.dart';

class TimesheetsTab extends StatelessWidget {
  const TimesheetsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const _Timesheets(
          showCompleted: false,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 4),
          child: Text("Completed Records"),
        ),
        const _Timesheets(
          showCompleted: true,
        ),
      ].toSlivers(),
    );
  }
}

class _Timesheets extends StatelessWidget {
  final bool showCompleted;
  const _Timesheets({required this.showCompleted});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskDetailBloc, TaskDetailState>(builder: (_, state) {

      if(state is! TaskDetailInitial) {
        return const SizedBox();
      }

      List<Timesheet> timesheets = showCompleted
          ? state.task!.completedTimesheets
          : state.task!.activeTimesheets;
      return Column(
        children: List.generate(
            timesheets.length,
            (index) => showCompleted
                ? CompletedTimesheetCard(timesheet: timesheets[index])
                : ActiveTimesheetCard(timesheet: timesheets[index])),
      );
    });
  }
}
