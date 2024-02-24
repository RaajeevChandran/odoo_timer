import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odoo_timer/models/models.dart';

part 'task_detail_event.dart';
part 'task_detail_state.dart';

class TaskDetailBloc extends Bloc<TaskDetailEvent, TaskDetailState> {
  TaskDetailBloc() : super(TaskDetailInitial()) {
    
    on<TaskDetailInit>((event, emit){
      emit(TaskDetailInitial(task: event.task));
    });

    on<DeletedTaskInTaskDetailEvent>((event, emit){
      emit(DeletedTaskInTaskDetail(task: event.task));
    });

    on<ToggleFavoriteEvent>((event, emit){
      if (state is TaskDetailInitial) {
        final task = (state as TaskDetailInitial).task!;

        task.isFavorite = !task.isFavorite;

        emit(FavoriteValueChanged(task: task));
        emit(TaskDetailInitial(task: task));
      }
    });

    on<CompletedTimesheetEvent>((event,emit) {
      if (state is TaskDetailInitial) {
         final task = (state as TaskDetailInitial).task!;
         task.timesheets.firstWhere((element) => element.id == event.timesheet.id).isCompleted = event.timesheet.isCompleted;
         emit(TaskDetailInitial(task: task));
      }
    });
    
  }
}
