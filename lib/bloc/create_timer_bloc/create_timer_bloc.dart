import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odoo_timer/models/models.dart';
import 'package:odoo_timer/utils/utils.dart';

part 'create_timer_event.dart';
part 'create_timer_state.dart';

class CreateTimerBloc extends Bloc<CreateTimerEvent, CreateTimerState> {
  CreateTimerBloc() : super(CreateTimerInitial(tasks: dummyTasks)) {
    on<CreateTimerScreenInit>((event, emit) {
      emit(CreateTimerInitial(tasks: event.tasks));
    });

    on<FormValueChanged>((event, emit) {
      if (state is CreateTimerInitial) {
        CreateTimerInitial currentState = state as CreateTimerInitial;
        switch (event.field) {
          case CreateTimerFormField.task:
            currentState = currentState.copyWith(
                tasks: currentState.tasks, task: event.value);
            break;
          case CreateTimerFormField.description:
            currentState = currentState.copyWith(
                tasks: currentState.tasks, description: event.value);
            break;
          case CreateTimerFormField.project:
            currentState = currentState.copyWith(
                tasks: currentState.tasks, project: event.value);
            break;
          default:
            currentState = currentState.copyWith(
                tasks: currentState.tasks, isFavorite: event.value);
        }
        emit(currentState);
      }
    });

    on<CreateTimerButtonTapEvent>((event, emit) {
      if (state is CreateTimerInitial) {
        final currentState = state as CreateTimerInitial;
        if (currentState.project != null && currentState.task != null) {
          currentState.task!.project = currentState.project!;
          currentState.task!.isFavorite = currentState.isFavorite;
          emit(CreateTimerFormValidationSuccess(task: currentState.task!, timesheet: Timesheet(
              id: DateTime.now().millisecondsSinceEpoch,
              description: currentState.description,
              taskId: currentState.task!.id,
              isFavorite: currentState.isFavorite)));
        } else {
          List<String> requiredFields = [
            CreateTimerFormField.project,
            CreateTimerFormField.task
          ].map((e) => e.name).toList();
          if (currentState.project != null) {
            requiredFields.removeAt(0);
          } else if (currentState.task != null) {
            requiredFields.removeAt(1);
          }
          emit(CreateTimerFormValidationError(
              message: "Please fill ${requiredFields.join(' and ')} fields"));
          emit(CreateTimerInitial(
              tasks: currentState.tasks,
              project: currentState.project,
              task: currentState.task,
              isFavorite: currentState.isFavorite,
              description: currentState.description));
        }
      }
    });
  }
}
