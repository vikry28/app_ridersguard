import 'package:app_riderguard/core/constants/colors_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarBase extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final bool showBackButton;
  final List<Widget>? actions;
  final VoidCallback? onBack;

  const AppBarBase({
    super.key,
    required this.title,
    this.centerTitle = true,
    this.showBackButton = true,
    this.actions,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: ColorsValue.background,
      automaticallyImplyLeading: false,
      leading: showBackButton
          ? IconButton(
              icon:
                  Icon(Icons.arrow_back_ios, size: 20.sp, color: Colors.black),
              onPressed: onBack ?? () => Navigator.of(context).pop(),
            )
          : null,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: centerTitle,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
