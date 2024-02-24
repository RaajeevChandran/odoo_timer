import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odoo_timer/bloc/task_detail_bloc/task_detail_bloc.dart';
import 'package:odoo_timer/bloc/tasks_bloc/tasks_bloc.dart';
import 'package:odoo_timer/models/models.dart';
import 'package:odoo_timer/screens/task_detail_screen/widgets/project_info_for_timesheet.dart';
import 'package:odoo_timer/screens/task_detail_screen/widgets/timesheet_description.dart';
import 'package:odoo_timer/utils/utils.dart';
import '../../../widgets/widgets.dart';

class ActiveTimesheetCard extends StatelessWidget {
  final Timesheet timesheet;
  const ActiveTimesheetCard({required this.timesheet, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        elevation: 0,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(15),
          width: double.infinity,
          decoration: BoxDecoration(
              color: context.colorScheme.secondary,
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProjectInfoForTimesheet(timesheet: timesheet,),
              _TimerInfo(timesheet: timesheet),
              if (timesheet.description.isNotEmpty) ...[
                const CustomDivider(),
                TimesheetDescription(timesheet: timesheet)
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class _TimerInfo extends StatelessWidget {
  final Timesheet timesheet;
  const _TimerInfo({required this.timesheet});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElapsedTimeWidget(
            timesheet: timesheet,
            forTaskDetailPage: true,
          ),
          BlocBuilder<TasksBloc, TaskState>(
            builder: (context, state) {
              if (state is! TaskInitialState) {
                return const SizedBox();
              }

              final _timesheet = state.tasks.getTimesheet(timesheet.id);

              return _timesheet.isCompleted
                  ? const SizedBox()
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                      if(_timesheet.startTime != null)  _TimerControlButton(
                          timesheet: timesheet,
                          icon: Icons.stop,
                          onTap: () {
                            context.read<TasksBloc>().add(
                                CompleteTimesheetEvent(timesheet: timesheet));
                            context.read<TaskDetailBloc>().add(
                                CompletedTimesheetEvent(timesheet: timesheet));
                          },
                          backgroundColor: context.colorScheme.tertiary,
                        ),
                        _TimerControlButton(
                          timesheet: timesheet,
                          icon: _timesheet.isRunning
                              ? Icons.pause
                              : Icons.play_arrow,
                          onTap: () {
                            context.read<TasksBloc>().add(
                                ToggleTimesheetEvent(timesheet: timesheet));
                          },
                          backgroundColor: context.colorScheme.primary,
                          iconColor: context.colorScheme.onPrimary,
                        ),
                      ].applyPadding(
                          const EdgeInsets.symmetric(horizontal: 4)));
            },
          )
        ],
      ),
    );
  }
}

class _TimerControlButton extends StatelessWidget {
  final Timesheet timesheet;
  final IconData icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final Function() onTap;

  const _TimerControlButton(
      {required this.timesheet,
      required this.icon,
      this.iconColor,
      this.backgroundColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TapAnimatable(
      onPressed: onTap,
      child: Container(
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: backgroundColor),
        height: 40,
        width: 40,
        child: Center(
          child: Icon(
            icon,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
