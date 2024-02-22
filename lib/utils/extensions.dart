import 'package:flutter/material.dart';

// A short-hand way of accessing the text theme
extension ThemeExtension on BuildContext {
  TextTheme get textTeme => Theme.of(this).textTheme;
}