import "package:intl/intl.dart";

extension StringUtils on String {
  String plural(int length) {
    return "$this${length > 1 ? "s" : ""}";
  }
}

extension DateTimeFormat on DateTime {
  String format() {
    return DateFormat("MM/dd/yyyy").format(this);
  }
}