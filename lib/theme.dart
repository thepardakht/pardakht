import 'package:flutter/material.dart';

class AppTheme {
  final ThemeData? lighTheme;
  final ThemeData? darkTheme;

  AppTheme({
    required this.lighTheme,
    required this.darkTheme,
  });
}

abstract class AppThemes {
  static final theme = ThemeData();
  static dark(ThemeData theme) {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'Lato',
      primaryColor: const Color(0xFFD1CE10),
    );
  }

  static light(ThemeData theme) {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: 'Lato',
      primaryColor: const Color(0xFF5184DB),
    );
  }
}
