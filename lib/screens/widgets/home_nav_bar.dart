import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:odoo_timer/utils/extensions.dart';

/// A custom navigation bar that implements the [PreferredSize] widget which is internally used
/// by default Flutter app bars for both Android and iOS
class HomeNavBar extends StatelessWidget implements PreferredSize {
  const HomeNavBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Timesheets",
                style: context.textTeme.headlineLarge,
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

  @override
  Widget get child => throw UnimplementedError();
}
