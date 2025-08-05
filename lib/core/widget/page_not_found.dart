import 'package:app_riderguard/core/constants/colors_value.dart';
import 'package:app_riderguard/core/constants/fonts.dart';
import 'package:app_riderguard/core/utils/assets_helper.dart';
import 'package:app_riderguard/module/general/widget/app_bar_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class PageNotFoundView extends StatelessWidget {
  const PageNotFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBase(
        title: 'Page Not Found',
        centerTitle: false,
      ),
      backgroundColor: ColorsValue.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              AssetsHelper.pagenotfound,
              width: 200.w,
              height: 200.h,
            ),
            SizedBox(height: 16.h),
            Text(
              'Oops! Halaman tidak ditemukan',
              style: AppFonts.titleFont.copyWith(fontSize: 16.sp),
            ),
            SizedBox(height: 8.h),
            TextButton(
              onPressed: () => context.go('/home'),
              child: Text(
                'Kembali ke Beranda',
                style: AppFonts.smallFont,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
