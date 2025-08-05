import 'package:app_riderguard/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffix;
  final Widget? prefixIcon;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final bool isValid;
  final StringValidatorType? validatorType;

  const CustomTextField({
    super.key,
    required this.label,
    this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffix,
    this.prefixIcon,
    this.onChanged,
    this.controller,
    this.isValid = false,
    this.validatorType,
  });

  String? _getValidator(String? value) {
    if (!isValid || validatorType == null || value == null) return null;
    return value.validate(validatorType!);
  }

  Widget _buildPhoneField(BuildContext context) {
    return IntlPhoneField(
      controller: controller,
      initialCountryCode: 'ID',
      style: TextStyle(
        fontSize: 14.sp,
      ),
      decoration: InputDecoration(
        hintText: hintText ?? '8123456789',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      ),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      dropdownTextStyle: const TextStyle(
        fontSize: 14,
      ),
      onChanged: onChanged == null
          ? null
          : (phone) => onChanged?.call(phone.completeNumber),
      validator: !isValid || validatorType == null
          ? null
          : (phone) => _getValidator(phone?.completeNumber),
      autovalidateMode: isValid ? AutovalidateMode.onUserInteraction : null,
      dropdownIconPosition: IconPosition.leading,
    );
  }

  Widget _buildNormalField(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      validator: _getValidator,
      autovalidateMode: isValid ? AutovalidateMode.onUserInteraction : null,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        SizedBox(height: 8.h),
        keyboardType == TextInputType.phone
            ? _buildPhoneField(context)
            : _buildNormalField(context),
        SizedBox(height: 8.h),
      ],
    );
  }
}
