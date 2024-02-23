part of 'tasks_bloc.dart';

@immutable
sealed class TaskEvent {}

final class AddTimesheetToTaskEvent extends TaskEvent {
  final Timesheet timesheet;

  AddTimesheetToTaskEvent({required this.timesheet});
}

final class ToggleTimesheetEvent extends TaskEvent {
  final Timesheet timesheet;

  ToggleTimesheetEvent({required this.timesheet});
}

