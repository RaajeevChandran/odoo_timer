part of 'timesheet_bloc.dart';

@immutable
abstract class TimesheetState {}

class TimesheetInitialState extends TimesheetState {
  final List<Timesheet> timesheets;

  TimesheetInitialState(this.timesheets);
}
