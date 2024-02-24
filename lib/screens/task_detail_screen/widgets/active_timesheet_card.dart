import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odoo_timer/bloc/task_detail_bloc/task_detail_bloc.dart';
import 'package:odoo_timer/bloc/tasks_bloc/tasks_bloc.dart';
import 'package:odoo_timer/models/models.dart';
import 'package:odoo_timer/utils/utils.dart';
import 'package:odoo_timer/widgets/elapsed_time_widget.dart';

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
              const _ProjectDetails(),
              _TimerInfo(timesheet: timesheet),
              const Divider(
                color: Colors.white,
                thickness: .5,
              ),
              _Description(timesheet: timesheet)
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectDetails extends StatelessWidget {
  const _ProjectDetails();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskDetailBloc, TaskDetailState>(builder: (_, state) {
      final currentState = state as TaskDetailInitial;

      if (currentState.task == null) {
        return const SizedBox();
      }

      Project project = currentState.task!.project;

      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(project.deadline.dayName, style: context.textTheme.bodySmall),
          Text(project.deadline.format(pattern: "MM.dd.yyyy"),
              style: context.textTheme.titleMedium),
          Text("Start Time 10:00", style: context.textTheme.bodySmall)
        ]
            .map((e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1),
                  child: e,
                ))
            .toList(),
      );
    });
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
              final _timesheet =
                  (state as TaskInitialState).tasks.getTimesheet(timesheet.id);

              return _timesheet.isCompleted
                  ? const SizedBox()
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _TimerControlButton(
                          timesheet: timesheet,
                          icon: Icons.stop,
                          onTap: () {
                            context.read<TasksBloc>().add(CompleteTimesheetEvent(timesheet: timesheet));
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
                        
                      ]
                          .map((e) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: e,
                              ))
                          .toList(),
                    );
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
    return GestureDetector(
      onTap: onTap,
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

class _Description extends StatelessWidget {
  final Timesheet timesheet;
  const _Description({required this.timesheet});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Description",
                style: context.textTheme.bodySmall,
              ),
              GestureDetector(
                onTap: () {},
                child: const Icon(CupertinoIcons.pencil),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            timesheet.description,
            style: context.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
