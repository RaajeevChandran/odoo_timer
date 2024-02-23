part of 'create_timer_bloc.dart';

sealed class CreateTimerState {}

class CreateTimerInitial extends CreateTimerState {
  final List<Task> tasks;
  Project? project;
  Task? task;
  String description;
  bool isFavorite;

  CreateTimerInitial({
     required this.tasks,
     this.project,
     this.task,
     this.description = "",
     this.isFavorite = false,
  });
}

class CreateTimerFormValidationError extends CreateTimerState {
  final String message;

  CreateTimerFormValidationError({required this.message});
}

class CreateTimerFormValidationSuccess extends CreateTimerState {
  final Task task;
  final Timesheet timesheet;

  CreateTimerFormValidationSuccess({required this.task, required this.timesheet});
}


extension CreateTimerInitialCopyWith on CreateTimerInitial {
  CreateTimerInitial copyWith({
    required List<Task> tasks,
    Project? project,
    Task? task,
    String? description,
    bool? isFavorite,
  }) {
    return CreateTimerInitial(
      tasks: tasks,
      project: project ?? this.project,
      task: task ?? this.task,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
