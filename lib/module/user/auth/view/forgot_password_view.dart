import 'package:app_riderguard/core/base/base_view.dart';
import 'package:app_riderguard/core/constants/colors_value.dart';
import 'package:app_riderguard/core/constants/fonts.dart';
import 'package:app_riderguard/core/utils/extensions.dart';
import 'package:app_riderguard/core/widget/base_container.dart';
import 'package:app_riderguard/core/widget/custom_button.dart';
import 'package:app_riderguard/core/widget/custom_text_field.dart';
import 'package:app_riderguard/module/user/auth/viewmodel/forgot_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ForgotPasswordViewModel>(
      viewModelBuilder: () => ForgotPasswordViewModel(),
      builder: (context, vm, _) => Scaffold(
        appBar: AppBar(
          title: Text(context.tr('forgot_password1')),
        ),
        body: BaseContainer(
          isScrollable: true,
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: vm.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 32.h),
                Text(
                  context.tr('reset_password'),
                  style: AppFonts.titleFont.copyWith(fontSize: 22.sp),
                ),
                SizedBox(height: 8.h),
                Text(
                  context.tr('reset_password_description'),
                  style: AppFonts.bodyFont.copyWith(color: ColorsValue.grey),
                ),
                SizedBox(height: 32.h),
                CustomTextField(
                  label: context.tr('email'),
                  hintText: 'example@email.com',
                  keyboardType: TextInputType.emailAddress,
                  controller: vm.email,
                  isValid: true,
                  validatorType: StringValidatorType.email,
                ),
                SizedBox(height: 24.h),
                CustomButton(
                  label: context.tr('send_reset_link'),
                  onPressed: () => vm.sendResetLink(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
