import 'package:app_riderguard/core/utils/assets_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Center(
            child: Lottie.asset(
              AssetsHelper.loading,
              width: 100.w,
              height: 100.w,
              fit: BoxFit.contain,
              repeat: true,
            ),
          ),
      ],
    );
  }
}
