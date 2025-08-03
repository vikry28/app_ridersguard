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

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterViewModel>(
      viewModelBuilder: () => RegisterViewModel(),
      builder: (context, vm, _) => Scaffold(
        appBar: AppBarBase(
          title: context.tr('register'),
        ),
        body: BaseContainer(
          isScrollable: true,
          child: Form(
            key: vm.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  label: context.tr('full_name'),
                  hintText: context.tr('your_name'),
                  controller: vm.fullName,
                  isValid: true,
                ),
                CustomTextField(
                  label: context.tr('user_name'),
                  hintText: context.tr('your_name'),
                  controller: vm.userName,
                  isValid: true,
                ),
                CustomTextField(
                  label: context.tr('email'),
                  hintText: 'example@email.com',
                  keyboardType: TextInputType.emailAddress,
                  controller: vm.email,
                  isValid: true,
                  validatorType: StringValidatorType.email,
                ),
                CustomTextField(
                  label: context.tr('phone'),
                  hintText: '+62',
                  keyboardType: TextInputType.phone,
                  controller: vm.phone,
                  isValid: true,
                  // validatorType: StringValidatorType.phone,
                ),
                CustomTextField(
                  label: context.tr('define_password'),
                  hintText: context.tr('password_placeholder'),
                  obscureText: !vm.isPasswordVisible,
                  controller: vm.password,
                  isValid: true,
                  validatorType: StringValidatorType.password,
                  suffix: IconButton(
                    icon: Icon(vm.isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: vm.togglePasswordVisibility,
                  ),
                ),
                const SizedBox(height: 8),
                _PasswordRuleItem(context.tr('password_rule_1'), true),
                _PasswordRuleItem(context.tr('password_rule_2'), true),
                _PasswordRuleItem(context.tr('password_rule_3'), true),
                _PasswordRuleItem(context.tr('password_rule_4'), false),
                const SizedBox(height: 16),
                CustomButton(
                  label: context.tr('create_account'),
                  onPressed: () => vm.register(context),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: context.tr('agree_terms'),
                      style: AppFonts.captionFont
                          .copyWith(color: ColorsValue.grey),
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
                )
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
        Icon(passed ? Icons.check : Icons.close,
            color: passed ? ColorsValue.alertGren : ColorsValue.healthIcon,
            size: 18),
        const SizedBox(width: 6),
        Text(label, style: AppFonts.captionFont),
      ],
    );
  }
}
