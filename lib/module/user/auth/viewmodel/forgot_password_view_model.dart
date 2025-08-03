import 'package:app_riderguard/core/base/view_model_base.dart';
import 'package:flutter/material.dart';

class ForgotPasswordViewModel extends ViewModelBase {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();

  void sendResetLink(BuildContext context) {
    if (!formKey.currentState!.validate()) return;
    final emailText = email.text.trim();
    debugPrint('Send reset link to: $emailText');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Link reset dikirim jika email valid.')),
    );
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }
}
