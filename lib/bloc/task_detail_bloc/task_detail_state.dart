part of 'task_detail_bloc.dart';

@immutable
sealed class TaskDetailState {}

final class TaskDetailInitial extends TaskDetailState {
  final Task? task;

  TaskDetailInitial({this.task});
}
