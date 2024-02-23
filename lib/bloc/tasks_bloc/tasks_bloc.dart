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
    (state as TaskInitialState).tasks.timesheetsFromAllTasks().forEach((timer) {
      timer.elapsedTimeStream.listen((elapsedTime) {
        final currentState = (state as TaskInitialState);
        
        final task = currentState.tasks.firstWhere((task) => task.id == timer.taskId);

        final updatedTimesheets = List<Timesheet>.from(task.timesheets);
        final timesheetIndex = updatedTimesheets.indexWhere((element) => element.id == timer.id);
        updatedTimesheets[timesheetIndex] = timer;

        task.timesheets = updatedTimesheets;

        // ignore: invalid_use_of_visible_for_testing_member
        emit(TaskInitialState(currentState.tasks));
      });
    });
  }


  void _onAddTimesheetToTaskEvent(AddTimesheetToTaskEvent event, Emitter<TaskState> emit) {
      final currentState = state as TaskInitialState;

      final task = currentState.tasks.firstWhere((task) => task.id == event.timesheet.taskId);

      task.timesheets.add(event.timesheet);

      emit(TaskInitialState(currentState.tasks));
  }

  void _onToggleTimesheetEvent(ToggleTimesheetEvent event, Emitter<TaskState> emit) {
      if (state is TaskInitialState) {
        final currentState = state as TaskInitialState;
        final task = currentState.tasks.firstWhere((task) => task.id == event.timesheet.taskId);

        final timer = task.timesheets.firstWhere((timesheet) => timesheet.id == event.timesheet.id);
        timer.toggle(); 

        emit(TaskInitialState(currentState.tasks));
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

