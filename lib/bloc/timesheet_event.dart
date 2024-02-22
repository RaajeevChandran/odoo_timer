part of 'timesheet_bloc.dart';

@immutable
sealed class TimesheetEvent {}

class AddTimeSheetEvent extends TimesheetEvent {}

class ToggleTimesheetEvent extends TimesheetEvent {
  final int index;

  ToggleTimesheetEvent(this.index);
}

