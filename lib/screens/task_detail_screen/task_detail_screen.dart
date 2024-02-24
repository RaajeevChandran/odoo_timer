import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odoo_timer/bloc/task_detail_bloc/task_detail_bloc.dart';
import 'package:odoo_timer/bloc/tasks_bloc/tasks_bloc.dart';
import 'package:odoo_timer/screens/task_detail_screen/widgets/details_tab.dart';
import 'package:odoo_timer/screens/task_detail_screen/widgets/edit_task_options.dart';
import 'package:odoo_timer/screens/task_detail_screen/widgets/timesheets_tab.dart';
import 'package:odoo_timer/utils/utils.dart';
import 'package:odoo_timer/widgets/custom_scaffold.dart';
import 'package:overlay_support/overlay_support.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({super.key});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskDetailBloc, TaskDetailState>(
      listener: (context, state) {
        if (state is DeletedTaskInTaskDetail) {
          context.read<TasksBloc>().add(DeleteTaskEvent(task: state.task));
          showSimpleNotification(
              Text("Deleted task", style: context.textTheme.bodyLarge),
              background: context.colorScheme.error);
          Navigator.pop(context);
        }else if(state is FavoriteValueChanged) {
          context.read<TasksBloc>().add(FavoriteValueChangedEvent(task: state.task));
        }
      },
      child: CustomScaffold(
          appBar: AppBar(
            title: BlocBuilder<TaskDetailBloc, TaskDetailState>(
                buildWhen: (previous, current) => current is TaskDetailInitial,
                builder: (_, state) =>
                    state is TaskDetailInitial && state.task != null
                        ? Text(
                            state.task!.name,
                            style: context.textTheme.headlineSmall
                          )
                        : const SizedBox()),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        backgroundColor: Theme.of(context).primaryColor,
                        builder: (_) => const EditTaskOptions());
                  },
                  icon: const Icon(CupertinoIcons.pencil))
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TabBar(
                  tabs: const [
                    Tab(
                      text: "Timesheets",
                    ),
                    Tab(
                      text: "Details",
                    )
                  ],
                  controller: tabController,
                ),
              ),
              Expanded(
                child: TabBarView(
                    controller: tabController,
                    children: const [TimesheetsTab(), DetailsTab()]
                        .applyPadding(const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 15))),
              ),
            ],
          )),
    );
  }
}
