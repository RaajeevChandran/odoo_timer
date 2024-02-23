import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:odoo_timer/models/models.dart';
import 'package:odoo_timer/utils/theme.dart';
import '../../widgets/widgets.dart';

class CreateTimerScreen extends StatelessWidget {
  const CreateTimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: AppBar(
          title: Text("Create Timer", style: context.textTheme.headlineLarge),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              const Align(alignment: Alignment.topCenter, child: _Form()),
              Align(
                alignment: Alignment.bottomCenter,
                child: PlatformElevatedButton(
                  child: const Text("Create Timer"),
                  onPressed: () {},
                ),
              )
            ],
          ),
        ));
  }
}

class _Form extends StatelessWidget {
  const _Form({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDropdown<String>(
          hintText: "Project",
          items: ["Project 1", "Project 2", "Project 3"]
              .map((e) => CustomDropdownItem<String>(value: e, label: e))
              .toList(),
          onChanged: (value) {},
        ),
      ],
    );
  }
}
