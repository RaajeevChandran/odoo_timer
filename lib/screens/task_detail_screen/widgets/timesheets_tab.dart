import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odoo_timer/bloc/task_detail_bloc/task_detail_bloc.dart';
import 'package:odoo_timer/screens/task_detail_screen/widgets/active_timesheet_card.dart';

import '../../../models/timesheet.dart';

class TimesheetsTab extends StatelessWidget {
  const TimesheetsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(
        children: [
          _ActiveTimesheets()
        ],
      ),
    );
  }
}

class _ActiveTimesheets extends StatelessWidget {
  const _ActiveTimesheets({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskDetailBloc, TaskDetailState>(
      builder: (_, state)  {
        final currenState = state as TaskDetailInitial;
        List<Timesheet> timesheets = currenState.task!.activeTimesheets;
        return Column(
        children: List.generate(timesheets.length, (index) => ActiveTimesheetCard(timesheet: timesheets[index])),
              );
      }
    );
  }
}