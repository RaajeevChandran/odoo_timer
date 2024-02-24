part of 'tasks_bloc.dart';

@immutable
abstract class TaskState {}

class TaskInitialState extends TaskState {
  final List<Task> tasks;

  TaskInitialState(this.tasks);
}

class TimesheetCreateButtonTapState extends TaskState {}
