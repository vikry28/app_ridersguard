import 'package:app_riderguard/core/constants/fonts.dart';
import 'package:app_riderguard/core/widget/custom_swith.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final String? trailingText;
  final bool showArrow;

  const ProfileItem({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.trailingText,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF7F8FA),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Row(
            children: [
              Icon(icon, color: Colors.deepPurple),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  label,
                  style: AppFonts.bodyFont,
                ),
              ),
              if (trailingText != null)
                Text(
                  trailingText!,
                  style: AppFonts.captionFont.copyWith(
                    color: Colors.grey.shade600,
                    fontSize: 15.sp,
                  ),
                ),
              if (showArrow) ...[
                SizedBox(width: 8.w),
                const Icon(Icons.arrow_forward_ios_rounded, size: 16),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileItemSwitch extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const ProfileItemSwitch({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF7F8FA),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: Colors.lightBlue),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                label,
                style: AppFonts.bodyFont,
              ),
            ),
            CustomSwitch(
              value: value,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
