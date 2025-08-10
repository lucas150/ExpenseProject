// import 'package:flutter/material.dart';

// class AppTheme {
//   static ThemeData lightTheme(Color? dynamicColor) {
//     // For simplicity, ignore dynamicColor for now
//     return ThemeData(
//       colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       useMaterial3: true,
//     );
//   }

//   static ThemeData darkTheme(Color? dynamicColor) {
//     return ThemeData(
//       brightness: Brightness.dark,
//       colorScheme: ColorScheme.fromSeed(
//         seedColor: Colors.deepPurple,
//         brightness: Brightness.dark,
//       ),
//       useMaterial3: true,
//     );
//   }

// }

import 'package:flutter/material.dart';

enum AppColors {
  surface,
  background,
  primary,
  onSurface,
  onBackground,
  onPrimary,
}

final palette = {
  AppColors.surface: Colors.white,
  AppColors.background: Colors.grey[50]!,
  AppColors.primary: Colors.deepPurple,
  AppColors.onSurface: Colors.black87,
  AppColors.onBackground: Colors.black87,
  AppColors.onPrimary: Colors.white,
};

class AppTheme {
  static ThemeData lightTheme(Color? dynamicColor) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        surface: palette[AppColors.surface]!,
        background: palette[AppColors.background]!,
        primary: palette[AppColors.primary]!,
        onSurface: palette[AppColors.onSurface]!,
        onBackground: palette[AppColors.onBackground]!,
        onPrimary: palette[AppColors.onPrimary]!,
        secondary: palette[AppColors.primary]!, // can reuse primary for now
        onSecondary: palette[AppColors.onPrimary]!,
        error: Colors.red,
        onError: Colors.white,
      ),
    );
  }

  static ThemeData darkTheme(Color? dynamicColor) {
    // Optionally, you can make a darker version of your palette for dark mode
    final darkPalette = {
      AppColors.surface: Colors.grey[900]!,
      AppColors.background: Colors.black,
      AppColors.primary: Colors.deepPurple[200]!,
      AppColors.onSurface: Colors.white70,
      AppColors.onBackground: Colors.white70,
      AppColors.onPrimary: Colors.black,
    };

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        surface: darkPalette[AppColors.surface]!,
        background: darkPalette[AppColors.background]!,
        primary: darkPalette[AppColors.primary]!,
        onSurface: darkPalette[AppColors.onSurface]!,
        onBackground: darkPalette[AppColors.onBackground]!,
        onPrimary: darkPalette[AppColors.onPrimary]!,
        secondary: darkPalette[AppColors.primary]!,
        onSecondary: darkPalette[AppColors.onPrimary]!,
        error: Colors.red[300]!,
        onError: Colors.black,
      ),
    );
  }
}
