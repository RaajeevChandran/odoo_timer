part of 'timesheet_bloc.dart';

@immutable
abstract class TimesheetState {}

class TimerInitialState extends TimesheetState {
  final List<Timesheet> timesheets;

  TimerInitialState(this.timesheets);
}
