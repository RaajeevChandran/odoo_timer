extension StringUtils on String {
  String plural(int length) {
    return "$this${length > 1 ? "s" : ""}";
  }
}