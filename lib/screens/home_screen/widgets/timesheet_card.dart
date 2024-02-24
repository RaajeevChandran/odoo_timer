import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:odoo_timer/bloc/task_detail_bloc/task_detail_bloc.dart';
import 'package:odoo_timer/bloc/tasks_bloc/tasks_bloc.dart';
import 'package:odoo_timer/models/models.dart';
import 'package:odoo_timer/screens/task_detail_screen/task_detail_screen.dart';
import 'package:odoo_timer/utils/utils.dart';
import 'package:odoo_timer/widgets/widgets.dart';

class TimesheetCard extends StatelessWidget {
  final Task task;
  final Timesheet timesheet;
  const TimesheetCard({required this.task, required this.timesheet, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TapAnimatable(
        onPressed: () {
          context.read<TaskDetailBloc>().add(TaskDetailInit(task: task));
          Navigator.push(context, platformPageRoute(context: context,builder: (_) => const TaskDetailsScreen()));
        },
        child: Material(
          elevation: 0,
          color: context.colorScheme.secondary,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: context.colorScheme.secondary,
            ),
            child: Row(
              children: [
                Container(
                  width: 2,
                  height: 85,
                  decoration: BoxDecoration(
                      color: AppPalette.sunglowYellow,
                      borderRadius: BorderRadius.circular(8)),
                ),
                const SizedBox(
                  width: 10,
                ),
                _TimesheetInfo(
                  task: task,
                  timesheet: timesheet,
                ),
                const SizedBox(
                  width: 5,
                ),
                _TimerToggle(timesheet: timesheet)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TimesheetInfo extends StatelessWidget {
  final Task task;
  final Timesheet timesheet;
  const _TimesheetInfo({required this.task, required this.timesheet});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.56),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _buildInfo(
            task.isFavorite
                ? CupertinoIcons.star_fill
                : CupertinoIcons.star,
            task.project.name,
            context.textTheme.titleMedium),
        _buildInfo(CupertinoIcons.bag, task.name, context.textTheme.bodyMedium),
        _buildInfo(
            CupertinoIcons.clock,
            "Deadline ${task.project.deadline.format()}",
            context.textTheme.bodyMedium),
      ]),
    );
  }

  Widget _buildInfo(IconData icon, String text, TextStyle? style) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 15,
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Text(
              text,
              style: style,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}

class _TimerToggle extends StatelessWidget {
  final Timesheet timesheet;
  const _TimerToggle({required this.timesheet});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
            color: !timesheet.isRunning
                ? context.colorScheme.tertiary
                : Colors.white,
            borderRadius: BorderRadius.circular(64)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ElapsedTimeWidget(timesheet: timesheet),
            if (!timesheet.isCompleted)
              TapAnimatable(
                child: Icon(
                  timesheet.isRunning ? Icons.pause : Icons.play_arrow,
                  color: timesheet.isRunning ? Colors.black : Colors.white,
                ),
                onPressed: () {
                  context
                      .read<TasksBloc>()
                      .add(ToggleTimesheetEvent(timesheet: timesheet));
                },
              )
          ],
        ),
      ),
    );
  }
}
