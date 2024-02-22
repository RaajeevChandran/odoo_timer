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
        Container(
          height: 192,width: 192,
          decoration: BoxDecoration(color: context.colorScheme.secondary, borderRadius: BorderRadius.circular(32)),
          child: Center(child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Image.asset(Assets.odooTextLogo,),
          ),),
        ),
        const SizedBox(height: 15,),
        Text(
          "You don't have any timesheets",
          style: context.textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Create a timer to begin tracking time",
          style: context.textTheme.bodyLarge,
        )
      ],
    ));
  }
}
