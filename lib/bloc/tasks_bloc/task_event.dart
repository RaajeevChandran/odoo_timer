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

final class CompleteTimesheetEvent extends TaskEvent {
  final Timesheet timesheet;

  CompleteTimesheetEvent({required this.timesheet});
}

final class DeleteTaskEvent extends TaskEvent {
  final Task task;

  DeleteTaskEvent({required this.task});
}

final class FavoriteValueChangedEvent extends TaskEvent {
  final Task task;
  FavoriteValueChangedEvent({required this.task});
}