part of 'create_timer_bloc.dart';

sealed class CreateTimerState {}

class CreateTimerInitial extends CreateTimerState {
  Project? project;
  Task? task;
  String description;
  bool isFavorite;

  CreateTimerInitial({
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
  final Timesheet timesheet;

  CreateTimerFormValidationSuccess(this.timesheet);
}


extension CreateTimerInitialCopyWith on CreateTimerInitial {
  CreateTimerInitial copyWith({
    Project? project,
    Task? task,
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
