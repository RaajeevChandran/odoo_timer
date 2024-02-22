import 'package:flutter/material.dart';
import 'package:odoo_timer/utils/utils.dart';

class NoTimesheetsWidget extends StatelessWidget {
  const NoTimesheetsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "You don't have any odoo timesheets",
                      style: context.textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Synchronize with odoo to get started",
                      style: context.textTheme.bodyLarge,
                    )
                  ],
                ));
  }
}