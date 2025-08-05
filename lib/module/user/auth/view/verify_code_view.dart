import 'package:app_riderguard/core/base/base_view.dart';
import 'package:app_riderguard/core/constants/colors_value.dart';
import 'package:app_riderguard/core/constants/fonts.dart';
import 'package:app_riderguard/core/utils/extensions.dart';
import 'package:app_riderguard/core/widget/base_container.dart';
import 'package:app_riderguard/core/widget/custom_button.dart';
import 'package:app_riderguard/module/general/widget/app_bar_base.dart';
import 'package:app_riderguard/module/user/auth/viewmodel/verify_code_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerifyCodeView extends StatelessWidget {
  final String email;

  const VerifyCodeView({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BaseView<VerifyCodeViewModel>(
      viewModelBuilder: () => VerifyCodeViewModel(email),
      builder: (context, vm, _) => Scaffold(
        appBar: AppBarBase(
          title: context.tr('verify_email_view'),
          centerTitle: false,
        ),
        backgroundColor: ColorsValue.background,
        body: BaseContainer(
          isScrollable: true,
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 64.h),
              Text(
                context.tr('verify_email'),
                style: AppFonts.titleFont.copyWith(fontSize: 22.sp),
              ),
              SizedBox(height: 8.h),
              Text(
                '${context.tr('we_sent_code')} ${vm.email}',
                style: AppFonts.bodyFont.copyWith(color: ColorsValue.grey),
              ),
              SizedBox(height: 32.h),
              _OTPInputField(
                controllers: vm.otpControllers,
                onChanged: vm.handleInputChange,
              ),
              SizedBox(height: 32.h),
              CustomButton(
                label: context.tr('continue'),
                onPressed: () => vm.verifyOTP(context),
              ),
              SizedBox(height: 16.h),
              Center(
                child: TextButton(
                  onPressed: vm.canResend ? () => vm.resendCode(context) : null,
                  child: Text(
                    vm.canResend
                        ? context.tr('resend_code')
                        : '${context.tr('resend_code_in')} ${vm.remainingSeconds}s',
                    style: AppFonts.captionFont.copyWith(
                      color: ColorsValue.blueAccent,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _OTPInputField extends StatelessWidget {
  final List<TextEditingController> controllers;
  final void Function(String value, int index) onChanged;

  const _OTPInputField({
    required this.controllers,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) {
        return SizedBox(
          width: 44.w,
          child: TextFormField(
            controller: controllers[index],
            keyboardType: TextInputType.number,
            maxLength: 1,
            textAlign: TextAlign.center,
            onChanged: (val) => onChanged(val, index),
            decoration: InputDecoration(
              counterText: '',
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    // ignore: deprecated_member_use
                    BorderSide(color: ColorsValue.grey.withOpacity(0.3)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: ColorsValue.blueAccent),
              ),
            ),
            style: AppFonts.titleFont.copyWith(fontSize: 18.sp),
          ),
        );
      }),
    );
  }
}
