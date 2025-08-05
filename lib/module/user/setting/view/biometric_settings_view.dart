import 'package:app_riderguard/core/base/base_view.dart';
import 'package:app_riderguard/core/constants/fonts.dart';
import 'package:app_riderguard/core/utils/extensions.dart';
import 'package:app_riderguard/core/widget/custom_swith.dart';
import 'package:app_riderguard/module/general/widget/app_bar_base.dart';
import 'package:app_riderguard/module/user/setting/viewmodel/biometric_settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BiometricSettingsView extends StatelessWidget {
  const BiometricSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<BiometricSettingsViewModel>(
      viewModelBuilder: () => BiometricSettingsViewModel(),
      onModelReady: (vm) => vm.init(),
      builder: (context, vm, _) {
        return Scaffold(
          appBar: AppBarBase(
            title: context.tr('biometric_settings'),
            centerTitle: false,
          ),
          body: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                if (vm.isBiometricSupported)
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text(context.tr('enable_biometric'),
                              style: AppFonts.bodyFont),
                          subtitle: Text(context.tr('enable_biometric_desc'),
                              style: AppFonts.captionFont),
                        ),
                      ),
                      CustomSwitch(
                        value: vm.isBiometricEnabled,
                        onChanged: vm.toggleBiometric,
                      ),
                    ],
                  )
                else
                  Text(
                    context.tr('biometric_not_supported'),
                    style: AppFonts.captionFont,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
