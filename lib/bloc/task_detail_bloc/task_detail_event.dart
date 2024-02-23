part of 'task_detail_bloc.dart';

@immutable
sealed class TaskDetailEvent {}

final class TaskDetailInit extends TaskDetailEvent {
  final Task task;

  TaskDetailInit({required this.task});
}