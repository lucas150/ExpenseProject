import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme(Color? dynamicColor) {
    // For simplicity, ignore dynamicColor for now
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    );
  }

  static ThemeData darkTheme(Color? dynamicColor) {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
    );
  }
}
