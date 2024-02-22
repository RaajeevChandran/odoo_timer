import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
      fontFamily: 'Inter-Regular',
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 57.0,
          height: 1.12,
        ),
        displayMedium: TextStyle(
          fontSize: 45.0,
          height: 1.15,
        ),
        displaySmall: TextStyle(
          fontSize: 36.0,
          height: 1.2,
        ),
        headlineLarge: TextStyle(
          fontSize: 32.0,
          height: 1.25,
        ),
        headlineMedium: TextStyle(
          fontSize: 28.0,
          height: 1.28,
        ),
        headlineSmall: TextStyle(
          fontSize: 24.0,
          height: 1.33,
        ),
      ));
}