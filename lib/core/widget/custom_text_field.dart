import 'package:app_riderguard/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffix;
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
    this.onChanged,
    this.controller,
    this.isValid = false,
    this.validatorType,
  });

  String? _getValidator(String? value) {
    if (!isValid || validatorType == null || value == null) return null;
    return value.validate(validatorType!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: TextInputAction.next,
          validator: _getValidator,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffix,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
