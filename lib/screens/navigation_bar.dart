import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:odoo_timer/utils/utils.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Timesheets",
                style: context.textTheme.headlineLarge,
              ),
              PlatformIconButton(
                  icon: const Icon(
                    Icons.add,
                    size: 24,
                  ),
                  onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
