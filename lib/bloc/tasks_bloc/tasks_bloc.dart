import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odoo_timer/models/models.dart';
import 'package:odoo_timer/utils/utils.dart';

part 'task_state.dart';
part 'task_event.dart';

class TasksBloc extends Bloc<TaskEvent, TaskState> {
  Map<int, List<StreamSubscription<String>>> _subscriptions = {};

  TasksBloc() : super(TaskInitialState(dummyTasks)) {
    on<AddTimesheetToTaskEvent>(_onAddTimesheetToTaskEvent);

    on<ToggleTimesheetEvent>(_onToggleTimesheetEvent);

    on<CompleteTimesheetEvent>(_onCompleteTimesheetevent);

    on<DeleteTaskEvent>(_onDeleteTaskEvent);

    on<FavoriteValueChangedEvent>(_onFavoriteValueChanged);
  }

  void _onAddTimesheetToTaskEvent(
      AddTimesheetToTaskEvent event, Emitter<TaskState> emit) {
    final currentState = state as TaskInitialState;

    final task = currentState.tasks
        .firstWhere((task) => task.id == event.timesheet.taskId);

    task.timesheets.add(event.timesheet);

    emit(TaskInitialState(currentState.tasks));
  }

  void _onToggleTimesheetEvent(
      ToggleTimesheetEvent event, Emitter<TaskState> emit) {
    if (state is TaskInitialState) {
      final currentState = state as TaskInitialState;
      final task = currentState.tasks
          .firstWhere((task) => task.id == event.timesheet.taskId);

      final timer = task.timesheets
          .firstWhere((timesheet) => timesheet.id == event.timesheet.id);
      timer.toggle();

      if (timer.isRunning) {
        _addSubscription(timer);
      } else {
        _removeSubscription(timer);
      }

      emit(TaskInitialState(currentState.tasks));
    }
  }

  void _onCompleteTimesheetevent(
      CompleteTimesheetEvent event, Emitter<TaskState> emit) {
    if (state is TaskInitialState) {
      final currentState = state as TaskInitialState;
      final timesheet = currentState.tasks.getTimesheet(event.timesheet.id);
      timesheet.markAsCompleted();
      _removeSubscription(timesheet);
      emit(TaskInitialState(currentState.tasks));
    }
  }

  void _onDeleteTaskEvent(DeleteTaskEvent event, Emitter<TaskState> emit) {
    if (state is TaskInitialState) {
      final currentState = state as TaskInitialState;
      currentState.tasks.removeWhere((task) => event.task.id == task.id);
      emit(TaskInitialState(currentState.tasks));
    }
  }

  void _onFavoriteValueChanged(FavoriteValueChangedEvent event, Emitter<TaskState> emit) {
    if (state is TaskInitialState) {
      final currentState = state as TaskInitialState;
      final taskIndex = currentState.tasks.indexWhere((element) => element.id == event.task.id);
      if(taskIndex != -1) {
        currentState.tasks[taskIndex] = event.task;
      }
      emit(TaskInitialState(currentState.tasks));
    }
  }

  void _addSubscription(Timesheet timer) {
    StreamSubscription<String> subscription =
        timer.elapsedTimeStream.listen((elapsedTime) {
      final currentState = (state as TaskInitialState);

      final task =
          currentState.tasks.firstWhere((task) => task.id == timer.taskId);

      final updatedTimesheets = List<Timesheet>.from(task.timesheets);

      final timesheetIndex =
          updatedTimesheets.indexWhere((element) => element.id == timer.id);

      updatedTimesheets[timesheetIndex] = timer;

      task.timesheets = updatedTimesheets;

      // ignore: invalid_use_of_visible_for_testing_member
      emit(TaskInitialState(currentState.tasks));
    });

    if (!_subscriptions.containsKey(timer.id)) {
      _subscriptions[timer.id] = [];
    }
    _subscriptions[timer.id]!.add(subscription);
  }

  void _removeSubscription(Timesheet timer) {
    if (_subscriptions.containsKey(timer.id)) {
      for (StreamSubscription<String> subscription
          in _subscriptions[timer.id]!) {
        subscription.cancel();
      }
      _subscriptions.remove(timer.id);
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
