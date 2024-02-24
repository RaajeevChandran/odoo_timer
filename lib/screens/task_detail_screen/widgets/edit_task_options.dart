import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odoo_timer/bloc/task_detail_bloc/task_detail_bloc.dart';
import 'package:odoo_timer/models/models.dart';
import 'package:odoo_timer/utils/utils.dart';
import 'package:odoo_timer/widgets/widgets.dart';

class EditTaskOptions extends StatelessWidget {
  const EditTaskOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskDetailBloc, TaskDetailState>(
      listener: (context, state) {
        if (state is DeletedTaskInTaskDetail) {
          Navigator.pop(context);
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        height: 180,
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        child: Center(
          child: BlocBuilder<TaskDetailBloc, TaskDetailState>(
            builder: (context, state) {
              if (state is! TaskDetailInitial) return const SizedBox();

              Task task = state.task!;

              return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) => index == 0
                      ? _Option(
                          icon: CupertinoIcons.delete,
                          label: "Delete",
                          onTap: () {
                            context
                                .read<TaskDetailBloc>()
                                .add(DeletedTaskInTaskDetailEvent(task: task));
                          })
                      : _Option(
                          icon: task.isFavorite
                              ? CupertinoIcons.star_fill
                              : CupertinoIcons.star,
                          label: task.isFavorite
                              ? "Remove from Favorites"
                              : "Favorite",
                          onTap: () {
                            context
                                .read<TaskDetailBloc>()
                                .add(ToggleFavoriteEvent(task: task));
                          }),
                  separatorBuilder: (_, __) => const CustomDivider(),
                  itemCount: 2);
            },
          ),
        ),
      ),
    );
  }
}

class _Option extends StatelessWidget {
  final IconData icon;
  final Function() onTap;
  final String label;
  const _Option({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Icon(
              icon,
              weight: 5,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(label,
                  style: context.textTheme.labelLarge
                      ?.copyWith(fontWeight: FontWeight.w600)),
            )
          ],
        ),
      ),
    );
  }
}
