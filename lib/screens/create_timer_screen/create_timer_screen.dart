import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:odoo_timer/bloc/create_timer_bloc/create_timer_bloc.dart';
import 'package:odoo_timer/bloc/timesheet_bloc/timesheet_bloc.dart';
import 'package:odoo_timer/models/models.dart';
import 'package:odoo_timer/utils/theme.dart';
import '../../widgets/widgets.dart';

class CreateTimerScreen extends StatelessWidget {
  const CreateTimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateTimerBloc(),
      child: BlocListener<TimesheetBloc, TimesheetState>(
        listener: (context, state) {
          Navigator.pop(context);
        },
        listenWhen: (previous, current) => (previous is TimesheetInitialState &&
            current is TimesheetInitialState &&
            previous.timesheets.length != current.timesheets.length),
        child: CustomScaffold(
            appBar: AppBar(
              title:
                  Text("Create Timer", style: context.textTheme.headlineLarge),
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  const Align(alignment: Alignment.topCenter, child: _Form()),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: PlatformElevatedButton(
                      child: const Text("Create Timer"),
                      onPressed: () {
                        context.read<TimesheetBloc>().add(AddTimesheetEvent());
                      },
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  const _Form();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDropdown<String>(
          hintText: "Project",
          items: ["Project 1", "Project 2", "Project 3"]
              .map((e) => CustomDropdownItem<String>(value: e, label: e))
              .toList(),
          onChanged: (value) {},
        ),
        CustomDropdown<String>(
          hintText: "Task",
          items: ["Project 1", "Project 2", "Project 3"]
              .map((e) => CustomDropdownItem<String>(value: e, label: e))
              .toList(),
          onChanged: (value) {},
        ),
        const CustomTextField()
      ],
    );
  }
}
