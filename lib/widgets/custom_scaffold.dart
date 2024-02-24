import 'package:flutter/material.dart';
import 'package:odoo_timer/utils/utils.dart';
import 'package:odoo_timer/widgets/responsive_widget.dart';

/// Creates a [Scaffold] widget with the gradient background as per design system
class CustomScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  const CustomScaffold({this.appBar, required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              context.colorScheme.background,
              context.colorScheme.surface,
            ],
          )),
          child: ResponsiveWidget(child: body)),
    );
  }
}
