import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odoo_timer/models/timesheet.dart';

part 'timesheet_state.dart';
part 'timesheet_event.dart';

class TimesheetBloc extends Bloc<TimesheetEvent, TimesheetState> {
  TimesheetBloc() : super(TimesheetInitialState(const [])) {
    
    on<AddTimesheetEvent>(_onAddTimesheetEvent);

    on<ToggleTimesheetEvent>(_onToggleTimeSheetEvent);

    on<TimesheetCreateButtonTapEvent>(_onTimesheetCreateButtonTap);

    // emits a state to facilitate the UI updation of elapsed time since the timer of timesheet started
    (state as TimesheetInitialState).timesheets.forEach((timer) {
      timer.elapsedTimeStream.listen((elapsedTime) {
        final updatedTimesheets = List<Timesheet>.from((state as TimesheetInitialState).timesheets);
        final index = updatedTimesheets.indexWhere((element) => element.id == timer.id);
        updatedTimesheets[index] = timer;
        // ignore: invalid_use_of_visible_for_testing_member
        emit(TimesheetInitialState(updatedTimesheets));
      });
    });
  }

  void _onTimesheetCreateButtonTap(TimesheetCreateButtonTapEvent event, Emitter<TimesheetState> emit) {
    emit(TimesheetCreateButtonTapState());
  }

  void _onAddTimesheetEvent(AddTimesheetEvent event, Emitter<TimesheetState> emit) {
      final currentState = state as TimesheetInitialState;

      final updatedTimesheets = List<Timesheet>.from(currentState.timesheets)
        ..add(Timesheet(DateTime.now().millisecondsSinceEpoch));

      emit(TimesheetInitialState(updatedTimesheets));
  }

  void _onToggleTimeSheetEvent(ToggleTimesheetEvent event, Emitter<TimesheetState> emit) {
      if (state is TimesheetInitialState) {
        final currentState = state as TimesheetInitialState;
        final timesheets = List<Timesheet>.from(currentState.timesheets);

        final timer = timesheets.firstWhere((timesheet) => timesheet.id == event.id);
        timer.toggle(); 

        emit(TimesheetInitialState(timesheets));
      }
  }

  @override
  Future<void> close() {
    (state as TimesheetInitialState).timesheets.forEach((timer) {
      timer.dispose();
    });
    return super.close();
  }
}

