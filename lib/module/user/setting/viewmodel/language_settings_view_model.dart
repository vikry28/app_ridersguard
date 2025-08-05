import 'package:app_riderguard/app.dart';
import 'package:app_riderguard/core/base/view_model_base.dart';
import 'package:app_riderguard/core/utils/shared_prefs.dart';
import 'package:flutter/material.dart';

class LanguageSettingsViewModel extends ViewModelBase {
  String currentLocale = 'id';

  @override
  Future<void> init() async {
    final savedLocale = SharedPrefs.getString('locale') ?? 'id';
    currentLocale = savedLocale;
    notifyListeners();
  }

  Future<void> changeLanguage(BuildContext context, String localeCode) async {
    if (currentLocale == localeCode) return;
    currentLocale = localeCode;
    await SharedPrefs.setString('locale', localeCode);
    notifyListeners();
    // ignore: use_build_context_synchronously
    MyApp.setLocale(context, Locale(localeCode));
  }
}
