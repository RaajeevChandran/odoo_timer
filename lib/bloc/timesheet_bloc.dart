import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odoo_timer/models/timesheet.dart';

part 'timesheet_state.dart';
part 'timesheet_event.dart';

class TimerBloc extends Bloc<TimesheetEvent, TimesheetState> {
  TimerBloc() : super(TimerInitialState(const [])) {
    
    on<AddTimeSheetEvent>((event, emit) {
      final currentState = state as TimerInitialState;

      final updatedTimers = List<Timesheet>.from(currentState.timesheets)
        ..add(Timesheet(DateTime.now().millisecondsSinceEpoch));

      emit(TimerInitialState(updatedTimers));
    });

    on<ToggleTimesheetEvent>((event, emit) {
      if (state is TimerInitialState) {
        final currentState = state as TimerInitialState;
        final timers = List<Timesheet>.from(currentState.timesheets);

        final timer = timers[event.index];
        timer.toggle(); 

        emit(TimerInitialState(timers));
      }
    });

    (state as TimerInitialState).timesheets.forEach((timer) {
      timer.elapsedTimeStream.listen((elapsedTime) {
        final updatedTimers = List<Timesheet>.from((state as TimerInitialState).timesheets);
        final index = updatedTimers.indexWhere((element) => element.id == timer.id);
        updatedTimers[index] = timer;
        // ignore: invalid_use_of_visible_for_testing_member
        emit(TimerInitialState(updatedTimers));
      });
    });
  }

  @override
  Future<void> close() {
    (state as TimerInitialState).timesheets.forEach((timer) {
      timer.dispose();
    });
    return super.close();
  }
}

