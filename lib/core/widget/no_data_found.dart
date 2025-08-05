import 'package:app_riderguard/core/constants/fonts.dart';
import 'package:app_riderguard/core/utils/assets_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class NoDataFoundWidget extends StatelessWidget {
  final String message;
  final String? lottieAsset;
  final double lottieSize;

  const NoDataFoundWidget({
    super.key,
    this.message = 'Data tidak ditemukan',
    this.lottieAsset,
    this.lottieSize = 180,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            lottieAsset ?? AssetsHelper.notfounddata,
            width: lottieSize,
            height: lottieSize,
          ),
          SizedBox(height: 16.h),
          Text(
            message,
            style: AppFonts.defaultFont,
          ),
        ],
      ),
    );
  }
}
