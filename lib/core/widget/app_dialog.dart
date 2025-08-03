import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_riderguard/core/constants/colors_value.dart';
import 'package:app_riderguard/core/constants/fonts.dart';

enum DialogType { success, error, info, warning }

class AppDialog {
  static Future<void> show(
    BuildContext context, {
    required String title,
    required String message,
    DialogType type = DialogType.info,
    String confirmText = 'OK',
    VoidCallback? onConfirm,
    bool barrierDismissible = true,
  }) {
    final icon = _getIcon(type);
    final color = _getColor(type);

    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 8.h),
        title: Column(
          children: [
            SizedBox(height: 16.h),
            Icon(icon, size: 48.w, color: color),
            SizedBox(height: 12.h),
            Text(
              title,
              style: AppFonts.titleFont.copyWith(fontSize: 18.sp),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        content: Text(
          message,
          style: AppFonts.bodyFont
              .copyWith(fontSize: 14.sp, color: ColorsValue.grey),
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: TextButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).maybePop();
                if (onConfirm != null) onConfirm();
              },
              style: TextButton.styleFrom(
                backgroundColor: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
              ),
              child: Text(
                confirmText,
                style: AppFonts.buttonFont.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static IconData _getIcon(DialogType type) {
    switch (type) {
      case DialogType.success:
        return Icons.check_circle_outline;
      case DialogType.error:
        return Icons.error_outline;
      case DialogType.warning:
        return Icons.warning_amber_rounded;
      case DialogType.info:
        return Icons.info_outline;
    }
  }

  static Color _getColor(DialogType type) {
    switch (type) {
      case DialogType.success:
        return ColorsValue.alertGren;
      case DialogType.error:
        return ColorsValue.healthIcon;
      case DialogType.warning:
        return ColorsValue.alertOrange;
      case DialogType.info:
        return ColorsValue.blueAccent;
    }
  }
}
