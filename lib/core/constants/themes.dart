import 'package:app_riderguard/core/constants/colors_value.dart';
import 'package:flutter/material.dart';
import 'fonts.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    fontFamily: AppFonts.defaultFont.fontFamily,
    colorScheme: ColorScheme.fromSeed(seedColor: ColorsValue.blueAccent),
    useMaterial3: true,
  );
}
