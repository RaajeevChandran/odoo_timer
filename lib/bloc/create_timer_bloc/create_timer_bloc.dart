import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_timer_event.dart';
part 'create_timer_state.dart';

class CreateTimerBloc extends Bloc<CreateTimerEvent, CreateTimerState> {
  CreateTimerBloc() : super(CreateTimerInitial()) {
    on<CreateTimerEvent>((event, emit) {

    });
  }
}
