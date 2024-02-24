import 'package:flutter/cupertino.dart';
import 'package:odoo_timer/utils/utils.dart';
import '../../../models/models.dart';

class TimesheetDescription extends StatelessWidget {
  final Timesheet timesheet;
  const TimesheetDescription({super.key, required this.timesheet});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Description",
                style: context.textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            timesheet.description,
            style: context.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
