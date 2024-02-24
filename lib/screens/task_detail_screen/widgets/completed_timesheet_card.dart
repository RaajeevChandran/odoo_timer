import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:odoo_timer/models/models.dart';
import 'package:odoo_timer/screens/task_detail_screen/widgets/project_info_for_timesheet.dart';
import 'package:odoo_timer/utils/utils.dart';

class CompletedTimesheetCard extends StatelessWidget {
  final Timesheet timesheet;
  const CompletedTimesheetCard({super.key, required this.timesheet});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Material(
            elevation: 0,
            borderRadius: BorderRadius.circular(15),
            child: Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: context.colorScheme.secondary,
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  const Icon(CupertinoIcons.check_mark_circled_solid),
                  const SizedBox(width: 10,),
                  const Expanded(child: ProjectInfoForTimesheet()),
                  Container(
                    decoration: BoxDecoration(
                      color: context.colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(64)
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                    child: Center(child: Text(timesheet.lastElapsedTime, style: context.textTheme.labelLarge,),),
                  )
                ],
              ),
            )));
  }
}
