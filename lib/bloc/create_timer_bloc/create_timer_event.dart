part of 'create_timer_bloc.dart';

@immutable
sealed class CreateTimerEvent {}

class CreateTimerScreenInit extends CreateTimerEvent {}

class FormValueChanged<T> extends CreateTimerEvent {
  final CreateTimerFormField field;
  final T value;

  FormValueChanged(this.field, this.value);
}

class CreateTimerButtonTapEvent extends CreateTimerEvent {}