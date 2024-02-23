import 'package:flutter/material.dart';

abstract class AppPalette {
  static const sunglowYellow = Color.fromRGBO(255, 198, 41, 1);
}

class AppTheme {
  static ThemeData theme = ThemeData(
      appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 12, 29, 77),
          scrolledUnderElevation: 0,
          iconTheme: IconThemeData(color: Colors.white)),
      iconTheme: const IconThemeData(color: Colors.white, size: 24),
      popupMenuTheme: const PopupMenuThemeData(
        elevation: 0,
      ),
      tabBarTheme: const TabBarTheme(
        dividerColor: Colors.white,
        dividerHeight: 0.5,
        indicatorSize: TabBarIndicatorSize.label,
        unselectedLabelColor: Colors.white
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith((states) => Colors.white),
        checkColor: MaterialStateColor.resolveWith((states) =>  Colors.black),
        overlayColor: MaterialStateColor.resolveWith((states) => Colors.white),
      ),
      dialogTheme: const DialogTheme(
        backgroundColor: Color.fromARGB(255, 58, 80, 144)
      ),
      colorScheme: const ColorScheme.light(
          brightness: Brightness.light,
          primary: Colors.white,
          onPrimary: Colors.black,
          primaryContainer: Colors.white,
          onPrimaryContainer: Colors.black,
          secondary: Color.fromARGB(255, 58, 80, 144),
          onSecondary: Colors.white,
          secondaryContainer: Color.fromARGB(255, 57, 79, 139),
          onSecondaryContainer: Colors.white,
          tertiary: Color.fromARGB(255, 97, 118, 176),
          onTertiary: Colors.black,
          tertiaryContainer: Color.fromARGB(255, 97, 117, 173),
          onTertiaryContainer: Colors.black,
          error: Color.fromARGB(255, 204, 60, 32),
          onError: Colors.white,
          errorContainer: Color.fromARGB(255, 82, 58, 112),
          onErrorContainer: Color.fromARGB(255, 204, 60, 32),
          background: Color.fromARGB(255, 12, 29, 77),
          surface: Color.fromARGB(255, 33, 78, 204)),
      textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontFamily: 'Inter-Regular',
            fontSize: 57.0,
            height: 1.12,
          ),
          displayMedium: TextStyle(
            fontFamily: 'Inter-Regular',
            fontSize: 45.0,
            height: 1.15,
          ),
          displaySmall: TextStyle(
            fontFamily: 'Inter-Regular',
            fontSize: 36.0,
            height: 1.2,
          ),
          headlineLarge: TextStyle(
              fontFamily: 'Inter-Regular',
              fontSize: 32.0,
              height: 1.25,
              fontWeight: FontWeight.w700),
          headlineMedium: TextStyle(
            fontFamily: 'Inter-Regular',
            fontSize: 28.0,
            height: 1.28,
          ),
          headlineSmall: TextStyle(
            fontFamily: 'Inter-Regular',
            fontSize: 24.0,
            height: 1.33,
          ),
          titleLarge: TextStyle(
              fontFamily: 'Inter-Regular',
              fontSize: 22.0,
              height: 1.27,
              color: Colors.white),
          titleMedium: TextStyle(
              fontFamily: 'Inter-Regular',
              fontSize: 16.0,
              height: 1.5,
              fontWeight: FontWeight.w700,
              color: Colors.white),
          titleSmall: TextStyle(
              fontFamily: 'Inter-Regular',
              fontSize: 14.0,
              height: 1.42,
              color: Colors.white),
          labelLarge: TextStyle(
              fontFamily: 'Roboto-Regular',
              fontSize: 14.0,
              height: 1.42,
              fontWeight: FontWeight.w500,
              color: Colors.white),
          labelMedium: TextStyle(
              fontFamily: 'Roboto-Regular',
              fontSize: 12.0,
              height: 1.33,
              color: Colors.white),
          labelSmall: TextStyle(
              fontFamily: 'Roboto-Regular',
              fontSize: 11.0,
              height: 1.45,
              color: Colors.white),
          bodyLarge: TextStyle(
            fontFamily: 'Inter-Regular',
            fontSize: 16.0,
            height: 1.5,
          ),
          bodyMedium: TextStyle(
              fontFamily: 'Inter-Regular',
              fontSize: 14.0,
              height: 1.42,
              fontWeight: FontWeight.w400),
          bodySmall: TextStyle(
            fontFamily: 'Inter-Regular',
            fontSize: 12.0,
            height: 1.33,
            color: Colors.white,
          )).apply(bodyColor: Colors.white, displayColor: Colors.white));
}

// A short-hand way of accessing the text theme
extension ThemeExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
