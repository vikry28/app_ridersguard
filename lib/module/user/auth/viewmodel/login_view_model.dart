// ignore_for_file: use_build_context_synchronously

import 'package:app_riderguard/core/base/view_model_base.dart';
import 'package:app_riderguard/core/networks/api_base.dart';
import 'package:app_riderguard/core/utils/logger.dart';
import 'package:app_riderguard/core/utils/shared_prefs.dart';
import 'package:app_riderguard/core/widget/app_dialog.dart';
import 'package:app_riderguard/module/user/auth/api/auth_api.dart';
import 'package:app_riderguard/module/user/auth/model/user_model.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class LoginViewModel extends ViewModelBase {
  AuthApi api = AuthApi();

  final formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isPasswordVisible = false;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  void login(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    setLoading(true);

    final data = {
      "username": email.text.trim(),
      "password": password.text.trim(),
    };

    try {
      final Map response = await api.login(data: data);
      logger.i('Login response: $response');

      if (response['status'] == 'success') {
        final String message = response['message'] ?? 'Login berhasil';
        final Map dataMap = response['data'] ?? {};

        final String accessToken = dataMap['accessToken'] ?? '';
        final String refreshToken = dataMap['refreshToken'] ?? '';
        final user = UserModel.fromJson(dataMap['user'] ?? {});

        await SharedPrefs.setString('accessToken', accessToken);
        await SharedPrefs.setString('refreshToken', refreshToken);
        await SharedPrefs.setString('user', user.toJson().toString());

        AppDialog.show(
          context,
          title: 'Berhasil',
          message: message,
          type: DialogType.success,
          onConfirm: () {
            context.go('/home');
          },
        );
      } else {
        AppDialog.show(
          context,
          title: 'Login Gagal',
          message: response['message'] ?? 'Terjadi kesalahan saat login',
          type: DialogType.error,
        );
      }
    } on ApiException catch (e) {
      logger.e('Login API exception', error: e);

      AppDialog.show(
        context,
        title: 'Login Gagal',
        message: e.message,
        type: DialogType.error,
      );
    } catch (e, stackTrace) {
      logger.e('Login unknown error', error: e, stackTrace: stackTrace);

      AppDialog.show(
        context,
        title: 'Terjadi Kesalahan',
        message: 'Gagal login. Coba lagi nanti.',
        type: DialogType.error,
      );
    } finally {
      setLoading(false);
    }
  }

  void forgotPassword() {}

  void loginWithGoogle() {}
  void loginWithSSO() {}
}
