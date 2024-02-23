import 'package:odoo_timer/models/models.dart';

final List<Project> projects = [
    Project(
      name: 'Project Alpha',
      assignedTo: 'Rupert Brown',
      deadline: DateTime(2024, 3, 15),
    ),
    Project(
      name: 'Project Beta',
      assignedTo: 'Jane Smith',
      deadline: DateTime(2024, 4, 20),
    ),
    Project(
      name: 'Project Gamma',
      assignedTo: 'Alice Johnson',
      deadline: DateTime(2024, 5, 10),
    ),
    Project(
      name: 'Project Delta',
      assignedTo: 'Bobby Nash',
      deadline: DateTime(2024, 6, 30),
    ),
    Project(
      name: 'Project Epsilon',
      assignedTo: 'Emily Wilson',
      deadline: DateTime(2024, 7, 25),
    ),
  ];

final List<Task> tasks = [
    Task(
      name: 'Design',
      description: 'Create logos that reflect the essence of the project',
    ),
    Task(
      name: 'Website',
      description: 'Build a captivating landing page to engage visitors',
    ),
];