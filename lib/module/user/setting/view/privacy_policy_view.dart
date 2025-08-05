import 'package:app_riderguard/core/utils/extensions.dart';
import 'package:app_riderguard/module/user/setting/viewmodel/privacy_policy_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_riderguard/core/base/base_view.dart';
import 'package:app_riderguard/core/constants/fonts.dart';
import 'package:app_riderguard/module/general/widget/app_bar_base.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<PrivacyPolicyViewModel>(
      viewModelBuilder: () => PrivacyPolicyViewModel(),
      onModelReady: (vm) => vm.loadLocalizedSections(context),
      builder: (context, vm, _) {
        return Scaffold(
          appBar: AppBarBase(
            title: context.tr('privacy_policy'),
            centerTitle: false,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: ListView.builder(
              itemCount: vm.sections.length,
              itemBuilder: (_, index) {
                final section = vm.sections[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        section['title']!,
                        style: AppFonts.titleFont.copyWith(fontSize: 16.sp),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        section['body']!,
                        style: AppFonts.bodyFont.copyWith(fontSize: 14.sp),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
