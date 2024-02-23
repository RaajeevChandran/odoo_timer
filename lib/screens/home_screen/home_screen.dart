import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:odoo_timer/bloc/create_timer_bloc/create_timer_bloc.dart';
import 'package:odoo_timer/bloc/timesheet_bloc/timesheet_bloc.dart';
import 'package:odoo_timer/screens/create_timer_screen/create_timer_screen.dart';
import 'package:odoo_timer/screens/home_screen/widgets/no_timesheets_widget.dart';
import 'package:odoo_timer/screens/home_screen/widgets/timesheet_card.dart';
import 'package:odoo_timer/utils/utils.dart';
import 'package:odoo_timer/widgets/custom_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: AppBar(
          title: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Timesheets",
                style: context.textTheme.headlineLarge,
              )),
          actions: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 4),
              child: Center(
                child: PlatformIconButton(
                  padding: EdgeInsets.zero,
                  color: context.colorScheme.secondary,
                  icon: const Icon(Icons.add, color: Colors.white), onPressed: (){
                    context.read<CreateTimerBloc>().add(CreateTimerScreenInit());
                    Navigator.of(context).push(platformPageRoute(context: context, builder: (context) => const CreateTimerScreen(),));
                  }),
              )),
          ],
        ),
        body: const _Body());
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: NestedScrollView(
          headerSliverBuilder: (_, __) => [const _TotalTimesheets()],
          body: const _TimesheetsListView()),
    );
  }
}

class _TotalTimesheets extends StatelessWidget {
  const _TotalTimesheets();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 10, left: 5, bottom: 10),
      sliver: SliverToBoxAdapter(
        child: BlocBuilder<TimesheetBloc, TimesheetState>(
          buildWhen:(previous, current) {
            return (current is TimesheetInitialState);
          },
          builder: (context, state) {
            int numberOfTimersheets =
                (state as TimesheetInitialState).timesheets.length;
            return numberOfTimersheets > 0
                ? Text(
                    "You have $numberOfTimersheets ${"timer".plural(numberOfTimersheets)}",
                    style: context.textTheme.labelLarge,
                  )
                : const SizedBox();
          },
        ),
      ),
    );
  }
}

class _TimesheetsListView extends StatelessWidget {
  const _TimesheetsListView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimesheetBloc, TimesheetState>(
      buildWhen: (previous, current) {
        return (current is TimesheetInitialState);
      },
      builder: (context, state) {
        state = state as TimesheetInitialState;

        if (state.timesheets.isEmpty) {
          return const NoTimesheetsWidget();
        }

        return ListView.builder(
            itemCount: state.timesheets.length,
            itemBuilder: (context, index) => TimesheetCard(
                  timesheet: (state as TimesheetInitialState).timesheets[index],
                ));
      },
    );
  }
}
