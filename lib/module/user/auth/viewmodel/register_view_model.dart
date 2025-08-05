// ignore_for_file: use_build_context_synchronously
import 'package:app_riderguard/core/base/view_model_base.dart';
import 'package:app_riderguard/core/networks/api_base.dart';
import 'package:app_riderguard/core/widget/app_dialog.dart';
import 'package:app_riderguard/module/user/auth/api/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterViewModel extends ViewModelBase {
  RegisterViewModel() {
    password.addListener(() {
      notifyListeners();
    });
  }

  AuthApi api = AuthApi();

  final formKey = GlobalKey<FormState>();

  final fullName = TextEditingController();
  final userName = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final address = TextEditingController();

  bool isPasswordVisible = false;
  bool get isMinLength => password.text.length >= 6;
  bool get hasUppercase => password.text.contains(RegExp(r'[A-Z]'));
  bool get hasNumber => password.text.contains(RegExp(r'[0-9]'));
  bool get hasSymbol =>
      password.text.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  void register(BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
      setLoading(true);

      final data = {
        "username": userName.text.trim(),
        "name": fullName.text.trim(),
        "email": email.text.trim(),
        "phone": phone.text.trim(),
        "address": address.text.trim().replaceAll('\u0000', ''),
        "role": 'USER',
        "password": password.text.trim(),
      };

      try {
        final Map response = await api.register(data: data);
        if (response['status'] == 'success') {
          final String message = response['message'] ?? 'Register berhasil';

          AppDialog.show(
            context,
            title: response['status'],
            message: message,
            type: DialogType.success,
            onConfirm: () {
              context.go('/verify', extra: email.text);
            },
          );
        } else {
          AppDialog.show(
            context,
            title: response['status'],
            message: response['message'] ?? 'Terjadi kesalahan saat Register',
            type: DialogType.error,
          );
        }
      } on ApiException catch (e) {
        AppDialog.show(
          context,
          title: 'Register Gagal',
          message: e.message,
          type: DialogType.error,
        );
      } catch (e) {
        AppDialog.show(
          context,
          title: 'Terjadi Kesalahan',
          message: '$e',
          type: DialogType.error,
        );
      } finally {
        setLoading(false);
      }
    }
  }
}
