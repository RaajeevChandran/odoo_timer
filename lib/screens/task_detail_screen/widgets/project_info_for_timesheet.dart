import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odoo_timer/bloc/task_detail_bloc/task_detail_bloc.dart';
import 'package:odoo_timer/models/models.dart';
import 'package:odoo_timer/utils/utils.dart';

class ProjectInfoForTimesheet extends StatelessWidget {
  const ProjectInfoForTimesheet({super.key});

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
        ].applyPadding(const EdgeInsets.symmetric(vertical: 1))
      );
    });
  }
}