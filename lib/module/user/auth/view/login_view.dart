import 'package:app_riderguard/core/base/base_view.dart';
import 'package:app_riderguard/core/constants/fonts.dart';
import 'package:app_riderguard/core/utils/assets_helper.dart';
import 'package:app_riderguard/core/utils/extensions.dart';
import 'package:app_riderguard/module/user/auth/viewmodel/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:app_riderguard/core/widget/custom_text_field.dart';
import 'package:app_riderguard/core/widget/custom_button.dart';
import 'package:app_riderguard/core/widget/base_container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_riderguard/core/constants/colors_value.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, vm, _) => Scaffold(
        backgroundColor: ColorsValue.background,
        body: BaseContainer(
          isScrollable: true,
          child: Form(
            key: vm.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                SizedBox(height: 20.w),
                Text(
                  context.tr('greeting'),
                  style: AppFonts.titleFont,
                ),
                SizedBox(height: 8.w),
                Text(
                  context.tr('login_prompt'),
                  style: AppFonts.bodyFont.copyWith(color: ColorsValue.grey),
                ),
                SizedBox(height: 24.w),
                CustomTextField(
                  label: context.tr('username_or_email'),
                  hintText: context.tr('email_placeholder'),
                  keyboardType: TextInputType.emailAddress,
                  controller: vm.email,
                  isValid: true,
                  validatorType: StringValidatorType.emailOrUsername,
                ),
                CustomTextField(
                  controller: vm.password,
                  label: context.tr('password'),
                  obscureText: !vm.isPasswordVisible,
                  hintText: '••••••••',
                  isValid: true,
                  validatorType: StringValidatorType.password,
                  suffix: IconButton(
                    onPressed: vm.togglePasswordVisibility,
                    icon: Icon(
                      vm.isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => context.push('/ForgotPassword'),
                    child: Text(
                      context.tr('forgot_password'),
                      style: AppFonts.captionFont.copyWith(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 8.w),
                CustomButton(
                    label: context.tr('login'),
                    onPressed: () async {
                      vm.login(context);
                    }),
                SizedBox(height: 24.w),
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Text(
                        context.tr('or_login_with'),
                        style: AppFonts.captionFont
                            .copyWith(color: ColorsValue.grey),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                SizedBox(height: 12.w),
                Row(
                  children: [
                    Expanded(
                      child: CustomOutlinedButton(
                        icon: Icons.g_mobiledata_rounded,
                        label: 'Google',
                        onPressed: vm.loginWithGoogle,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: CustomOutlinedButton(
                        icon: Icons.vpn_key,
                        label: 'SSO',
                        onPressed: vm.loginWithSSO,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.tr('dont_have_account'),
                      style: AppFonts.bodyFont,
                    ),
                    TextButton(
                      onPressed: () => context.push('/register'),
                      child: Text(
                        context.tr('sign_up'),
                        style: AppFonts.buttonFont.copyWith(
                          color: ColorsValue.blueAccent,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.w),
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
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 16.w),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
