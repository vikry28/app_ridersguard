import 'package:flutter/material.dart';
import 'fonts.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    fontFamily: AppFonts.defaultFont.fontFamily,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
    useMaterial3: true,
  );
}
