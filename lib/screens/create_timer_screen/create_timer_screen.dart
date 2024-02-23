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
    return BlocListener<TimesheetBloc, TimesheetState>(
      listener: (context, state) {
        Navigator.pop(context);
      },
      listenWhen: (previous, current) => (previous is TimesheetInitialState &&
          current is TimesheetInitialState &&
          previous.timesheets.length != current.timesheets.length),
      child: CustomScaffold(
          appBar: AppBar(
            title: Text("Create Timer", style: context.textTheme.headlineLarge),
          ),
          body: SafeArea(
            child: Stack(
              children: [
                Align(alignment: Alignment.topCenter, child: _Form()),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: PlatformElevatedButton(
                    child: const Text("Create Timer"),
                    onPressed: () {
                      // context.read<TimesheetBloc>().add(AddTimesheetEvent());
                      context.read<CreateTimerBloc>().add(ValidateFormEvent());
                    },
                  ),
                )
              ],
            ),
          )),
    );
  }
}

class _Form extends StatelessWidget {
  // const _Form();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(CreateTimerFormField.values.length, (index) {
          final field = CreateTimerFormField.values[index];
          switch (index) {
            case 2:
              return CustomTextField(
                hintText: field.name,
                onChanged: (value) {
                  context
                      .read<CreateTimerBloc>()
                      .add(TextValueChanged(field.name, value ?? ""));
                },
              );
            default:
              return CustomDropdown<String>(
                hintText: field.name,
                items: ["Project 1", "Project 2", "Project 3"]
                    .map((e) => CustomDropdownItem<String>(value: e, label: e))
                    .toList(),
                onChanged: (dropdown) {
                  context
                      .read<CreateTimerBloc>()
                      .add(TextValueChanged(field.name, dropdown.value));
                },
              );
          }
        }),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          child: Row(
            children: [
              BlocBuilder<CreateTimerBloc, CreateTimerState>(
                builder: (context, state) {
                  print("state ${(state as CreateTimerInitial).isFavorite}");
                  return Checkbox(
                      value: (state as CreateTimerInitial).isFavorite,
                      onChanged: (value) {
                        context
                            .read<CreateTimerBloc>()
                            .add(FavoriteCheckboxValueChanged(value ?? false));
                      });
                },
              ),
              const Text("Make Favorite")
            ],
          ),
        )
      ],
    );
  }
}
