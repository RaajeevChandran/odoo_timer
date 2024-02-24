import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odoo_timer/bloc/create_timer_bloc/create_timer_bloc.dart';
import 'package:odoo_timer/bloc/tasks_bloc/tasks_bloc.dart';
import 'package:odoo_timer/models/models.dart';
import 'package:odoo_timer/utils/utils.dart';
import 'package:overlay_support/overlay_support.dart';
import '../../widgets/widgets.dart';

class CreateTimerScreen extends StatelessWidget {
  const CreateTimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateTimerBloc, CreateTimerState>(
      listener: (context, state) {
        if (state is CreateTimerFormValidationSuccess) {
          context
              .read<TasksBloc>()
              .add(AddTimesheetToTaskEvent(timesheet: state.timesheet));
          Navigator.pop(context);
        } else if (state is CreateTimerFormValidationError) {
          showSimpleNotification(
              Text(state.message, style: context.textTheme.bodyLarge),
              background: context.colorScheme.error);
        }
      },
      child: CustomScaffold(
          appBar: AppBar(
            title: Text("Create Timer", style: context.textTheme.headlineSmall),
          ),
          body: const SafeArea(
            child: Stack(
              children: [
                Align(alignment: Alignment.topCenter, child: _Form()),
                _CreateTimerButton()
              ],
            ),
          )),
    );
  }
}

class _Form extends StatelessWidget {
  const _Form();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(CreateTimerFormField.values.length, (index) {
        final field = CreateTimerFormField.values[index];
        switch (field) {
          case CreateTimerFormField.description:
            return CustomTextField(
              hintText: field.name,
              onChanged: (value) {
                context
                    .read<CreateTimerBloc>()
                    .add(FormValueChanged<String>(field, value ?? ""));
              },
            );
          case CreateTimerFormField.project:
            return CustomDropdown<Project>(
              hintText: field.name,
              items: projects
                  .map((e) => CustomDropdownItem(value: e, label: e.name))
                  .toList(),
              onChanged: (dropdown) {
                context
                    .read<CreateTimerBloc>()
                    .add(FormValueChanged<Project>(field, dropdown.value));
              },
            );
          case CreateTimerFormField.task:
            return CustomDropdown<Task>(
              hintText: field.name,
              items: dummyTasks
                  .map((e) => CustomDropdownItem(value: e, label: e.name))
                  .toList(),
              onChanged: (dropdown) {
                context
                    .read<CreateTimerBloc>()
                    .add(FormValueChanged<Task>(field, dropdown.value));
              },
            );
          default:
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: BlocBuilder<CreateTimerBloc, CreateTimerState>(
                buildWhen: (previous, current) => current is CreateTimerInitial,
                builder: (context, state) {
                  bool isFavorite = (state as CreateTimerInitial).isFavorite;

                  void onChanged(bool? value) {
                    context
                        .read<CreateTimerBloc>()
                        .add(FormValueChanged<bool>(field, value ?? false));
                  }

                  return Row(
                    children: [
                      Checkbox(value: isFavorite, onChanged: onChanged),
                      TapAnimatable(
                          onPressed: () {
                            onChanged(!isFavorite);
                          },
                          child: const Text("Make Favorite"))
                    ],
                  );
                },
              ),
            );
        }
      }),
    );
  }
}

class _CreateTimerButton extends StatelessWidget {
  const _CreateTimerButton();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: TapAnimatable(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
          child: Container(
              height: 48,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: context.colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(15)),
              child: Center(
                  child: Text(
                "Create Timer",
                style: context.textTheme.labelLarge,
              ))),
        ),
        onPressed: () {
          context.read<CreateTimerBloc>().add(CreateTimerButtonTapEvent());
        },
      ),
    );
  }
}
