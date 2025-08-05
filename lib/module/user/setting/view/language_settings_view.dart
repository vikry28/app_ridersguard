import 'package:app_riderguard/core/base/base_view.dart';
import 'package:app_riderguard/core/constants/fonts.dart';
import 'package:app_riderguard/core/utils/extensions.dart';
import 'package:app_riderguard/module/general/widget/app_bar_base.dart';
import 'package:app_riderguard/module/user/setting/viewmodel/language_settings_view_model.dart';
import 'package:flutter/material.dart';

class LanguageSettingsView extends StatelessWidget {
  const LanguageSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<LanguageSettingsViewModel>(
      viewModelBuilder: () => LanguageSettingsViewModel(),
      onModelReady: (vm) => vm.init(),
      builder: (context, vm, _) {
        return Scaffold(
          appBar: AppBarBase(
            title: context.tr('language'),
            centerTitle: false,
          ),
          body: ListView(
            children: [
              _buildLanguageTile(
                context: context,
                label: '🇮🇩 Bahasa Indonesia',
                localeCode: 'id',
                selected: vm.currentLocale == 'id',
                onTap: () => vm.changeLanguage(context, 'id'),
              ),
              _buildLanguageTile(
                context: context,
                label: '🇺🇸 English',
                localeCode: 'en',
                selected: vm.currentLocale == 'en',
                onTap: () => vm.changeLanguage(context, 'en'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageTile({
    required BuildContext context,
    required String label,
    required String localeCode,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(
        label,
        style: AppFonts.bodyFont,
      ),
      trailing:
          selected ? const Icon(Icons.check_circle, color: Colors.green) : null,
      onTap: onTap,
    );
  }
}
