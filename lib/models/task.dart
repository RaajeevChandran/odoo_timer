import 'package:odoo_timer/models/models.dart';

class Task {
  final String id, name, description;
  Project project;
  List<Timesheet> timesheets = [];
  bool isFavorite;

  Task(
      {required this.id,
      required this.name,
      required this.project,
      required this.description,
      this.isFavorite = false});

  List<Timesheet> get activeTimesheets {
    return timesheets.where((timesheet) => !timesheet.isCompleted).toList();
  }

  List<Timesheet> get completedTimesheets {
    return timesheets.where((timesheet) => timesheet.isCompleted).toList();
  }
  
}

extension TaskExtension on List<Task> {
  List<Timesheet> timesheetsFromAllTasks() {
    List<Timesheet> timesheets = [];
    for (Task task in this) {
      timesheets.addAll(task.timesheets);
    }
    return timesheets;
  }

  Timesheet getTimesheet(int id) {
    return timesheetsFromAllTasks().firstWhere((element) => element.id == id);
  }
}
