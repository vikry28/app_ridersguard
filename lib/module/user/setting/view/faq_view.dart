import 'package:app_riderguard/core/base/base_view.dart';
import 'package:app_riderguard/core/utils/extensions.dart';
import 'package:app_riderguard/module/general/widget/app_bar_base.dart';
import 'package:app_riderguard/module/user/setting/viewmodel/faq_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_riderguard/core/constants/fonts.dart';

class FaqView extends StatelessWidget {
  const FaqView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<FaqViewModel>(
      viewModelBuilder: () => FaqViewModel(),
      onModelReady: (vm) => vm.initWithContext(context),
      builder: (context, vm, _) {
        return Scaffold(
          appBar: AppBarBase(
            title: context.tr('faq'),
            centerTitle: false,
          ),
          body: ListView.separated(
            padding: EdgeInsets.all(16.w),
            itemCount: vm.faqList.length,
            separatorBuilder: (_, __) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              final faq = vm.faqList[index];
              return ExpansionTile(
                tilePadding: EdgeInsets.symmetric(horizontal: 12.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
                title: Text(
                  faq.question,
                  style:
                      AppFonts.bodyFont.copyWith(fontWeight: FontWeight.w600),
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Text(
                      faq.answer,
                      style: AppFonts.captionFont,
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
