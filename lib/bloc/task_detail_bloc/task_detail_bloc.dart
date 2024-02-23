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
    
  }
}
