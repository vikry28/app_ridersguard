import 'package:app_riderguard/core/base/base_view.dart';
import 'package:app_riderguard/core/constants/colors_value.dart';
import 'package:app_riderguard/core/utils/assets_helper.dart';
import 'package:app_riderguard/core/utils/extensions.dart';
import 'package:app_riderguard/module/general/widget/app_bar_base.dart';
import 'package:app_riderguard/module/user/setting/viewmodel/app_version_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_riderguard/core/constants/fonts.dart';

class AppVersionView extends StatelessWidget {
  const AppVersionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<AppVersionViewModel>(
      viewModelBuilder: () => AppVersionViewModel(),
      onModelReady: (vm) => vm.init(),
      builder: (context, vm, ref) {
        return Scaffold(
          appBar: AppBarBase(
            title: context.tr('app_version'),
            centerTitle: false,
          ),
          body: Center(
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: Image.asset(
                      AssetsHelper.logo,
                      width: 100.w,
                      height: 100.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                  // SizedBox(height: 16.h),
                  // Text(
                  //   context.tr('about_app'),
                  //   style: AppFonts.titleFont.copyWith(fontSize: 18.sp),
                  // ),
                  SizedBox(height: 12.h),
                  Text(
                    context.tr('about_app_description'),
                    style: AppFonts.bodyFont.copyWith(fontSize: 14.sp),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Version ${vm.version}',
                    style: AppFonts.smallFont.copyWith(color: ColorsValue.grey),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
