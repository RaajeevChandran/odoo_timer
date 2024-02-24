import 'package:flutter/material.dart';
import 'package:odoo_timer/utils/utils.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget child;
  final bool shouldCenterContent;
  const ResponsiveWidget({super.key, required this.child, this.shouldCenterContent = true});

  @override
  Widget build(BuildContext context) {
    double? width = context.getMaxContentWidth();
    return shouldCenterContent ? Center(
      child: SizedBox(
        width: width,
        child: child,
      ),
    ) : SizedBox(
        width: width,
        child: child,
      );
  }
}