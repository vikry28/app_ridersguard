import 'package:app_riderguard/core/base/view_model_base.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterViewModel extends ViewModelBase {
  final formKey = GlobalKey<FormState>();

  final fullName = TextEditingController();
  final userName = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();

  bool isPasswordVisible = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  void register(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      context.go('/verify', extra: email.text);
    }
  }
}
