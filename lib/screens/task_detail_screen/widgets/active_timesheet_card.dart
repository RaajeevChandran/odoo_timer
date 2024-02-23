import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odoo_timer/bloc/task_detail_bloc/task_detail_bloc.dart';
import 'package:odoo_timer/models/models.dart';
import 'package:odoo_timer/models/project.dart';
import 'package:odoo_timer/utils/utils.dart';

class ActiveTimesheetCard extends StatelessWidget {
  final Timesheet timesheet;
  const ActiveTimesheetCard({required this.timesheet, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
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
            _ProjectDetails(),
            _TimerInfo(timesheet: timesheet),
            Divider(
              color: Colors.white,
              thickness: .5,
            ),
            _Description(timesheet: timesheet)
          ],
        ),
      ),
    );
  }
}

class _ProjectDetails extends StatelessWidget {
  const _ProjectDetails({super.key});

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
  const _TimerInfo({required this.timesheet, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "08:06:23",
            style: context.textTheme.displaySmall,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _TimerControlButton(timesheet: timesheet, icon: Icons.stop, onTap: (){}, backgroundColor: context.colorScheme.tertiary,),
              _TimerControlButton(timesheet: timesheet, icon: Icons.play_arrow, onTap: (){}, backgroundColor: context.colorScheme.primary, iconColor: context.colorScheme.onPrimary,)
            ].map((e) => Padding(padding: EdgeInsets.symmetric(horizontal: 4),child: e,)).toList(),
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

  const _TimerControlButton({required this.timesheet, required this.icon, this.iconColor, this.backgroundColor, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: (){},child: Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: backgroundColor),
      height: 40,
      width: 40,
      child: Center(child: Icon(icon, color: iconColor,),),
    ),);
  }
}

class _Description extends StatelessWidget {
  final Timesheet timesheet;
  const _Description({required this.timesheet, super.key});

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
              Text("Description", style: context.textTheme.bodySmall,),
              GestureDetector(onTap: () {}, child: Icon(CupertinoIcons.pencil), )
            ],
          ),
          const SizedBox(height: 10,),
          Text("In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.", style: context.textTheme.bodyMedium,),
        ],
      ),
    );
  }
}
