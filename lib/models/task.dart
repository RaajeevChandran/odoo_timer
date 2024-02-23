import 'package:odoo_timer/models/models.dart';

class Task {
  final String id, name, description;
  Project project;
  List<Timesheet> timesheets = [];

  Task(
      {required this.id,
      required this.name,
      required this.project,
      required this.description});
}

extension TaskExtension on List<Task> {
  List<Timesheet> timesheetsFromAllTasks() {
    List<Timesheet> timesheets = [];
    for (Task task in this) {
      timesheets.addAll(task.timesheets);
    }
    return timesheets;
  }
}
