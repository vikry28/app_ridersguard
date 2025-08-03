import 'package:app_riderguard/core/localization/app_localizations.dart';
import 'package:flutter/material.dart';

enum StringValidatorType { email, password, required, emailOrUsername }

extension StringExt on String {
  String? validate(StringValidatorType type) {
    switch (type) {
      case StringValidatorType.email:
        final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
        return emailRegex.hasMatch(this) ? null : 'Email tidak valid';
      case StringValidatorType.emailOrUsername:
        final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
        final usernameRegex = RegExp(r"^[a-zA-Z0-9_.-]{3,}$");
        return (emailRegex.hasMatch(this) || usernameRegex.hasMatch(this))
            ? null
            : 'Masukkan email atau username yang valid';
      case StringValidatorType.password:
        return length >= 6 ? null : 'Password minimal 6 karakter';
      case StringValidatorType.required:
        return isNotEmpty ? null : 'Wajib diisi';
    }
  }
}

extension TranslateExt on BuildContext {
  String tr(String key) => AppLocalizations.of(this)!.translate(key);
  Locale get locale => Localizations.localeOf(this);
}
