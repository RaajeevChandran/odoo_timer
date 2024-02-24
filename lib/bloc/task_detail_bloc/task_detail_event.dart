part of 'task_detail_bloc.dart';

@immutable
sealed class TaskDetailEvent {}

final class TaskDetailInit extends TaskDetailEvent {
  final Task task;

  TaskDetailInit({required this.task});
}

final class DeletedTaskInTaskDetailEvent extends TaskDetailEvent {
  final Task task;

  DeletedTaskInTaskDetailEvent({required this.task});
}

final class ToggleFavoriteEvent extends TaskDetailEvent {
  final Task task;

  ToggleFavoriteEvent({required this.task});
}

final class CompletedTimesheetEvent extends TaskDetailEvent {
  final Timesheet timesheet;

  CompletedTimesheetEvent({required this.timesheet});
}
