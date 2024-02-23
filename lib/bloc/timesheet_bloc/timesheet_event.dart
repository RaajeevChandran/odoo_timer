part of 'timesheet_bloc.dart';

@immutable
sealed class TimesheetEvent {}

class AddTimesheetEvent extends TimesheetEvent {}

class TimesheetCreateButtonTapEvent extends TimesheetEvent {}

class ToggleTimesheetEvent extends TimesheetEvent {
  final int id;

  ToggleTimesheetEvent(this.id);
}

