import 'package:app_riderguard/core/constants/colors_value.dart';
import 'package:flutter/material.dart';
import 'fonts.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    fontFamily: AppFonts.defaultFont.fontFamily,
    colorScheme: ColorScheme.fromSeed(seedColor: ColorsValue.blueAccent),
    useMaterial3: true,
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: AppFonts.defaultFont.fontFamily,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorsValue.blueAccent,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  );
}
