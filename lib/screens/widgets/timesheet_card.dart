import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odoo_timer/bloc/timesheet_bloc.dart';
import 'package:odoo_timer/utils/utils.dart';
import '../../models/timesheet.dart';

class TimesheetCard extends StatelessWidget {
  final Timesheet timesheet;
  const TimesheetCard({required this.timesheet, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        elevation: 0,
        color: context.colorScheme.secondary,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: context.colorScheme.secondary,
          ),
          child: Row(
            children: [
              Container(
                width: 2,
                height: 85,
                decoration: BoxDecoration(
                    color: AppPalette.sunglowYellow,
                    borderRadius: BorderRadius.circular(8)),
              ),
              const SizedBox(
                width: 10,
              ),
              _TimesheetInfo(
                timesheet: timesheet,
              ),
              const SizedBox(
                width: 5,
              ),
              _TimerToggle(timesheet: timesheet)
            ],
          ),
        ),
      ),
    );
  }
}

class _TimesheetInfo extends StatelessWidget {
  final Timesheet timesheet;
  const _TimesheetInfo({required this.timesheet});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.56),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _buildInfo(CupertinoIcons.star, "iOS App Development",
            context.textTheme.titleMedium),
        _buildInfo(CupertinoIcons.bag, "SO056 - Booqio V2",
            context.textTheme.bodyMedium),
        _buildInfo(CupertinoIcons.clock, "Deadline 07/20/2023",
            context.textTheme.bodyMedium),
      ]),
    );
  }

  Widget _buildInfo(IconData icon, String text, TextStyle? style) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15,),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Text(
              text,
              style: style,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}

class _TimerToggle extends StatelessWidget {
  final Timesheet timesheet;
  const _TimerToggle({required this.timesheet});

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
              color: !timesheet.isRunning ? context.colorScheme.secondary : Colors.white, borderRadius: BorderRadius.circular(64)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<String>(
                stream: timesheet.elapsedTimeStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData || snapshot.data == null) {
                    return Text(
                      snapshot.data == null ? "00:00" : snapshot.data!,
                      style: context.textTheme.labelLarge?.copyWith(color: !timesheet.isRunning ? Colors.white: Colors.black),
                    );
                  }
                  return Container();
                },
              ),
              GestureDetector(
                    child: Icon(
                      timesheet.isRunning ? Icons.pause : Icons.play_arrow,
                      color: timesheet.isRunning ? Colors.black : Colors.white,
                    ),
                    onTap: () {
                      context
                          .read<TimesheetBloc>()
                          .add(ToggleTimesheetEvent(timesheet.id));
                    },
                  )
            ],
          ),
        );
  }
}
