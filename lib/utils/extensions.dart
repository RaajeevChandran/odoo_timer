import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:responsive_builder/responsive_builder.dart";
import "package:responsive_sizer/responsive_sizer.dart";

extension ScreenSizeFromContext on BuildContext {
  double? getMaxContentWidth() {
    double? width;
    switch (getDeviceType(MediaQuery.of(this).size)) {
      case DeviceScreenType.desktop:
        width = Adaptive.w(40);
        break;
      case DeviceScreenType.tablet:
        width = Adaptive.w(75);
        break;
      default:
        width = null;
    }
    return width;
  }
}

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
    return map((e) => SliverToBoxAdapter(
          child: e,
        )).toList();
  }

  List<Widget> applyPadding(EdgeInsetsGeometry padding) {
    return map((e) => Padding(
          padding: padding,
          child: e,
        )).toList();
  }
}
