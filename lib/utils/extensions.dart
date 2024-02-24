import "package:flutter/material.dart";
import "package:intl/intl.dart";

extension StringUtils on String {
  String plural(int length) {
    return "$this${length > 1 ? "s" : ""}";
  }
}

extension DateTimeFormat on DateTime {
  String format({String pattern = "MM/dd/yyyy"}) {
    return DateFormat(pattern).format(this);
  }

  String get dayName {
    return DateFormat('EEEE').format(this);
  }
}

extension SliverExtension on List<Widget> {
  List<Widget> toSlivers() {
    return map((e) => SliverToBoxAdapter(child: e,)).toList();
  }

  List<Widget> applyPadding(EdgeInsetsGeometry padding) {
    return map((e) => Padding(padding: padding, child: e,)).toList();
  }
}