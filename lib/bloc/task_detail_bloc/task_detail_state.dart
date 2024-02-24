part of 'task_detail_bloc.dart';

@immutable
sealed class TaskDetailState {}

final class TaskDetailInitial extends TaskDetailState {
  final Task? task;

  TaskDetailInitial({this.task});
}

final class DeletedTaskInTaskDetail extends TaskDetailState {
  final Task task;

  DeletedTaskInTaskDetail({required this.task});
}

final class FavoriteValueChanged extends TaskDetailState {
  final Task task;

  FavoriteValueChanged({required this.task});
}
