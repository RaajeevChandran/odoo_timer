import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odoo_timer/models/models.dart';

part 'create_timer_event.dart';
part 'create_timer_state.dart';

class CreateTimerBloc extends Bloc<CreateTimerEvent, CreateTimerState> {
  CreateTimerBloc() : super(CreateTimerInitial()) {
    on<CreateTimerScreenInit>((event, emit) {
      emit(CreateTimerInitial());
    });

    on<FormValueChanged>((event, emit) {
      if (state is CreateTimerInitial) {
        CreateTimerInitial currentState = state as CreateTimerInitial;
        switch (event.field) {
          case CreateTimerFormField.task:
            currentState = currentState.copyWith(task: event.value);
            break;
          case CreateTimerFormField.description:
            currentState = currentState.copyWith(description: event.value);
            break;
          case CreateTimerFormField.project:
            currentState = currentState.copyWith(project: event.value);
            break;
          default:
            currentState = currentState.copyWith(isFavorite: event.value);
        }
        emit(currentState);
      }
    });

    on<CreateTimerButtonTapEvent>((event, emit) {
      if (state is CreateTimerInitial) {
        final currentState = state as CreateTimerInitial;
        if (currentState.project != null && currentState.task != null) {
          emit(CreateTimerFormValidationSuccess(Timesheet(
              id: DateTime.now().millisecondsSinceEpoch,
              project: currentState.project!,
              task: currentState.task!,
              isFavorite: currentState.isFavorite)));
        }else {
          List<String> requiredFields = [CreateTimerFormField.project, CreateTimerFormField.task].map((e) => e.name).toList();
          if(currentState.project != null) {
            requiredFields.removeAt(0);
          }else if(currentState.task != null) {
            requiredFields.removeAt(1);
          }
          emit(CreateTimerFormValidationError(message: "Please fill ${requiredFields.join(' and ')} fields"));
          emit(CreateTimerInitial(project: currentState.project, task: currentState.task, isFavorite: currentState.isFavorite, description: currentState.description));
        }
      }
    });
  }
}
