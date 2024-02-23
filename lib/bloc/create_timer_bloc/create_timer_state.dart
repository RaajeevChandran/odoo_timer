part of 'create_timer_bloc.dart';

@immutable
sealed class CreateTimerState {}

final class CreateTimerInitial extends CreateTimerState {
  String project;
  String task;
  String description;
  bool isFavorite;

  CreateTimerInitial({
    required this.project,
    required this.task,
    required this.description,
    required this.isFavorite,
  });
}

extension CreateTimerInitialCopyWith on CreateTimerInitial {
  CreateTimerInitial copyWith({
    String? project,
    String? task,
    String? description,
    bool? isFavorite,
  }) {
    return CreateTimerInitial(
      project: project ?? this.project,
      task: task ?? this.task,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}