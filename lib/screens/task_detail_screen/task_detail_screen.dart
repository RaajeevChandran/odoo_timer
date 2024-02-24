import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odoo_timer/bloc/task_detail_bloc/task_detail_bloc.dart';
import 'package:odoo_timer/screens/task_detail_screen/widgets/details_tab.dart';
import 'package:odoo_timer/screens/task_detail_screen/widgets/timesheets_tab.dart';
import 'package:odoo_timer/utils/utils.dart';
import 'package:odoo_timer/widgets/custom_scaffold.dart';

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
    return CustomScaffold(
        appBar: AppBar(
          title: BlocBuilder<TaskDetailBloc, TaskDetailState>(
              buildWhen: (previous, current) => current is TaskDetailInitial,
              builder: (_, state) =>
                  state is TaskDetailInitial && state.task != null
                      ? Text(
                          state.task!.name,
                          style: context.textTheme.headlineLarge,
                        )
                      : const SizedBox()),
          centerTitle: true,
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
                              vertical: 20, horizontal: 15))
              ),
            ),
          ],
        ));
  }
}
