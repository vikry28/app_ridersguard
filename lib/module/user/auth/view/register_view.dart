import 'package:app_riderguard/core/base/base_view.dart';
import 'package:app_riderguard/core/constants/colors_value.dart';
import 'package:app_riderguard/core/constants/fonts.dart';
import 'package:app_riderguard/core/utils/extensions.dart';
import 'package:app_riderguard/core/widget/base_container.dart';
import 'package:app_riderguard/core/widget/custom_button.dart';
import 'package:app_riderguard/core/widget/custom_text_field.dart';
import 'package:app_riderguard/module/general/widget/app_bar_base.dart';
import 'package:app_riderguard/module/user/auth/viewmodel/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterViewModel>(
      viewModelBuilder: () => RegisterViewModel(),
      builder: (context, vm, _) => Scaffold(
        appBar: AppBarBase(title: context.tr('register')),
        backgroundColor: ColorsValue.background,
        body: BaseContainer(
          isScrollable: true,
          showScrollbar: true,
          child: Form(
            key: vm.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "📝 ${context.tr('register_subtitle')}",
                  style: AppFonts.subtitleFont,
                ),
                SizedBox(height: 4.h),
                Text(
                  context.tr('your_data_is_safe'),
                  style: AppFonts.captionFont.copyWith(color: ColorsValue.grey),
                ),
                SizedBox(height: 10.h),
                CustomTextField(
                  label: context.tr('full_name'),
                  hintText: context.tr('your_name'),
                  controller: vm.fullName,
                  isValid: true,
                  // prefixIcon: const Icon(Icons.person_outline),
                ),
                SizedBox(height: 10.h),
                CustomTextField(
                  label: context.tr('user_name'),
                  hintText: context.tr('your_name'),
                  controller: vm.userName,
                  isValid: true,
                  // prefixIcon: const Icon(Icons.account_circle_outlined),
                ),
                SizedBox(height: 10.h),
                CustomTextField(
                  label: context.tr('email'),
                  hintText: 'example@email.com',
                  keyboardType: TextInputType.emailAddress,
                  controller: vm.email,
                  isValid: true,
                  validatorType: StringValidatorType.email,
                  // prefixIcon: const Icon(Icons.email_outlined),
                ),
                SizedBox(height: 10.h),
                CustomTextField(
                  label: context.tr('phone'),
                  keyboardType: TextInputType.phone,
                  controller: vm.phone,
                  isValid: true,
                  // prefixIcon: const Icon(Icons.phone_android_outlined),
                ),
                CustomTextField(
                  label: context.tr('address'),
                  hintText: 'Jln.',
                  keyboardType: TextInputType.streetAddress,
                  controller: vm.address,
                  isValid: true,
                  // prefixIcon: const Icon(Icons.phone_android_outlined),
                ),
                SizedBox(height: 10.h),
                CustomTextField(
                  label: context.tr('define_password'),
                  hintText: context.tr('password_placeholder'),
                  obscureText: !vm.isPasswordVisible,
                  controller: vm.password,
                  isValid: true,
                  validatorType: StringValidatorType.password,
                  // prefixIcon: const Icon(Icons.lock_outline),
                  suffix: IconButton(
                    icon: Icon(vm.isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: vm.togglePasswordVisibility,
                  ),
                ),
                SizedBox(height: 12.h),
                _PasswordRuleItem(
                    context.tr('password_rule_1'), vm.isMinLength),
                _PasswordRuleItem(
                    context.tr('password_rule_2'), vm.hasUppercase),
                _PasswordRuleItem(context.tr('password_rule_3'), vm.hasNumber),
                _PasswordRuleItem(context.tr('password_rule_4'), vm.hasSymbol),
                SizedBox(height: 24.h),
                CustomButton(
                  label: context.tr('create_account'),
                  onPressed: () => vm.register(context),
                ),
                SizedBox(height: 12.h),
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: context.tr('agree_terms'),
                      style: AppFonts.captionFont.copyWith(
                        color: ColorsValue.grey,
                      ),
                      children: [
                        TextSpan(
                          text: context.tr('terms_of_use'),
                          style: AppFonts.captionFont.copyWith(
                            decoration: TextDecoration.underline,
                            color: ColorsValue.blueAccent,
                          ),
                        ),
                        TextSpan(text: ' ${context.tr('and')} '),
                        TextSpan(
                          text: context.tr('privacy_policy'),
                          style: AppFonts.captionFont.copyWith(
                            decoration: TextDecoration.underline,
                            color: ColorsValue.blueAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PasswordRuleItem extends StatelessWidget {
  final String label;
  final bool passed;

  const _PasswordRuleItem(this.label, this.passed);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          passed ? Icons.check : Icons.close,
          color: passed ? ColorsValue.alertGren : ColorsValue.healthIcon,
          size: 18,
        ),
        SizedBox(width: 6.w),
        Text(label, style: AppFonts.captionFont),
      ],
    );
  }
}
