import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odoo_timer/bloc/timesheet_bloc.dart';
import 'package:odoo_timer/screens/widgets/home_page_nav_bar.dart';
import 'package:odoo_timer/screens/widgets/no_timesheets_widget.dart';
import 'package:odoo_timer/screens/widgets/timesheet_card.dart';
import 'package:odoo_timer/utils/utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(appBar: HomePageNavBar(), body: _Body());
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
        child: Text(
          "You have 16 timers",
          style: context.textTheme.labelLarge,
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
      builder: (context, state) {
        state = state as TimesheetInitialState;

        if (state.timesheets.isEmpty) {
          return const NoTimesheetsWidget();
        }

        return ListView.builder(
          itemCount: state.timesheets.length,
          itemBuilder: (context, index) {
            return TimesheetCard(timesheet: (state as TimesheetInitialState).timesheets[index],);
          },
        );
      },
    );
  }
}
