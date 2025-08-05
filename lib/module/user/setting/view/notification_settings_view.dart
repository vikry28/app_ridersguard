import 'package:app_riderguard/core/base/base_view.dart';
import 'package:app_riderguard/core/constants/fonts.dart';
import 'package:app_riderguard/core/utils/extensions.dart';
import 'package:app_riderguard/core/widget/custom_swith.dart';
import 'package:app_riderguard/module/general/widget/app_bar_base.dart';
import 'package:app_riderguard/module/user/setting/viewmodel/notification_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationSettingsView extends StatelessWidget {
  const NotificationSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<NotificationSettingsViewModel>(
      viewModelBuilder: () => NotificationSettingsViewModel(),
      onModelReady: (vm) => vm.init(),
      builder: (context, vm, _) {
        return Scaffold(
          appBar: AppBarBase(
            title: context.tr('notification_settings'),
            centerTitle: false,
          ),
          body: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                _buildSwitchTile(
                  context: context,
                  title: context.tr('push_notification'),
                  subtitle: context.tr('push_notification_desc'),
                  value: vm.pushEnabled,
                  onChanged: vm.togglePush,
                ),
                const Divider(),
                _buildSwitchTile(
                  context: context,
                  title: context.tr('email_notification'),
                  subtitle: context.tr('email_notification_desc'),
                  value: vm.emailEnabled,
                  onChanged: vm.toggleEmail,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSwitchTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            title: Text(title, style: AppFonts.bodyFont),
            subtitle: Text(subtitle, style: AppFonts.captionFont),
          ),
        ),
        CustomSwitch(value: value, onChanged: onChanged),
      ],
    );
  }
}
