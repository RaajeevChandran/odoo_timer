import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odoo_timer/models/custom_dropdown_item.dart';

part 'create_timer_event.dart';
part 'create_timer_state.dart';

class CreateTimerBloc extends Bloc<CreateTimerEvent, CreateTimerState> {
  CreateTimerBloc()
      : super(CreateTimerInitial(
            project: "", task: "", description: "", isFavorite: false)) {

    on<TextValueChanged>((event, emit) {
      if (state is CreateTimerInitial) {
        final currentState = state as CreateTimerInitial;
        switch (event.label) {
          case "Task":
            currentState.task = event.value;
            break;
          case "Description":
          currentState.description = event.value;
          break;
          default:
            currentState.project = event.value;
            break;
        }
        emit(currentState);
      }
    });


    on<FavoriteCheckboxValueChanged>((event, emit){
      if (state is CreateTimerInitial) {
        final currentState = state as CreateTimerInitial;
        emit(currentState.copyWith(isFavorite: event.value));
      }
    });

    on<ValidateFormEvent>((event, emit) {
      inspect((state as CreateTimerInitial));
    });
  }
}
