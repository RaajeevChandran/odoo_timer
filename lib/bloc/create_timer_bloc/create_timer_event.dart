part of 'create_timer_bloc.dart';

@immutable
sealed class CreateTimerEvent {}

class TextValueChanged extends CreateTimerEvent {
  final String label, value;

  TextValueChanged(this.label, this.value);
}



class FavoriteCheckboxValueChanged extends CreateTimerEvent {
  final bool value;

  FavoriteCheckboxValueChanged(this.value);
}

class ValidateFormEvent extends CreateTimerEvent {}