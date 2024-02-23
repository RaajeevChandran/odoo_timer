import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odoo_timer/models/models.dart';
import 'package:odoo_timer/utils/utils.dart';

part 'task_state.dart';
part 'task_event.dart';

class TasksBloc extends Bloc<TaskEvent, TaskState> {
  TasksBloc() : super(TaskInitialState(dummyTasks)) {
    
    on<AddTimesheetToTaskEvent>(_onAddTimesheetToTaskEvent);

    on<ToggleTimesheetEvent>(_onToggleTimesheetEvent);

    // emits a state to facilitate the UI updation of elapsed time since the timer of timesheet started
    // (state as TaskInitialState).timesheets.forEach((timer) {
    //   timer.elapsedTimeStream.listen((elapsedTime) {
    //     final updatedTimesheets = List<Timesheet>.from((state as TaskInitialState).timesheets);
    //     final index = updatedTimesheets.indexWhere((element) => element.id == timer.id);
    //     updatedTimesheets[index] = timer;
    //     // ignore: invalid_use_of_visible_for_testing_member
    //     emit(TaskInitialState(updatedTimesheets));
    //   });
    // });
  }


  void _onAddTimesheetToTaskEvent(AddTimesheetToTaskEvent event, Emitter<TaskState> emit) {
      final currentState = state as TaskInitialState;

      final task = currentState.tasks.firstWhere((task) => task.id == event.timesheet.task.id);

      task.timesheets.add(event.timesheet);

      emit(TaskInitialState(currentState.tasks));
  }

  void _onToggleTimesheetEvent(ToggleTimesheetEvent event, Emitter<TaskState> emit) {
      if (state is TaskInitialState) {
        final currentState = state as TaskInitialState;
        final task = currentState.tasks.firstWhere((task) => task.id == event.timesheet.task.id);
        // final timesheets = List<Timesheet>.from(currentState.timesheets);

        // final timer = timesheets.firstWhere((timesheet) => timesheet.id == event.id);
        // timer.toggle(); 

        // emit(TaskInitialState(timesheets));
      }
  }

  @override
  Future<void> close() {
    // (state as TaskInitialState).timesheets.forEach((timer) {
    //   timer.dispose();
    // });
    return super.close();
  }
}

