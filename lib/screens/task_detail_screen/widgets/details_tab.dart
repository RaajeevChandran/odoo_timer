import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odoo_timer/bloc/task_detail_bloc/task_detail_bloc.dart';
import 'package:odoo_timer/models/models.dart';
import 'package:odoo_timer/utils/utils.dart';

class DetailsTab extends StatelessWidget {
  const DetailsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: const [_ProjectInfo(), _Description()]
          .toSlivers(),
    );
  }
}

class _ProjectInfo extends StatelessWidget {
  const _ProjectInfo();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskDetailBloc, TaskDetailState>(
      builder: (context, state) {
        Project project = (state as TaskDetailInitial).task!.project;

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
                _ProjectInfoRow(
                  label: "Project",
                  content: project.name,
                  showProjectColor: true,
                ),
                _ProjectInfoRow(
                    label: "Deadline", content: project.deadline.format()),
                _ProjectInfoRow(
                    label: "Assigned to", content: project.assignedTo)
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProjectInfoRow extends StatelessWidget {
  final String label, content;
  final bool showProjectColor;
  const _ProjectInfoRow(
      {required this.label,
      required this.content,
      this.showProjectColor = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: context.textTheme.bodySmall,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showProjectColor)
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Container(
                    color: AppPalette.sunglowYellow,
                    height: 15,
                    width: 2,
                  ),
                ),
              Text(
                content,
                style: context.textTheme.titleMedium,
              )
            ],
          )
        ],
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskDetailBloc, TaskDetailState>(
        builder: (context, state) {
      Task task = (state as TaskDetailInitial).task!;
      return Padding(
        padding: const EdgeInsets.only(top: 12.0),
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
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Description",
                          style: context.textTheme.bodyMedium,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      task.description,
                      style: context.textTheme.titleSmall,
                    )
                  ],
                ))),
      );
    });
  }
}
