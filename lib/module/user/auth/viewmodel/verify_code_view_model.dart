// ignore_for_file: use_build_context_synchronously

import 'package:app_riderguard/core/base/view_model_base.dart';
import 'package:app_riderguard/core/networks/api_base.dart';
import 'package:app_riderguard/core/widget/app_dialog.dart';
import 'package:app_riderguard/core/widget/app_snackbar.dart';
import 'package:app_riderguard/module/user/auth/api/auth_api.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:go_router/go_router.dart';

class VerifyCodeViewModel extends ViewModelBase {
  final String email;
  final List<TextEditingController> otpControllers =
      List.generate(6, (_) => TextEditingController());
  final AuthApi _api = AuthApi();

  Timer? _resendTimer;
  int _remainingSeconds = 30;

  VerifyCodeViewModel(this.email) {
    _startResendTimer();
  }

  int get remainingSeconds => _remainingSeconds;
  bool get canResend => _remainingSeconds == 0;

  void _startResendTimer() {
    _remainingSeconds = 30;
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds == 0) {
        timer.cancel();
        notifyListeners();
      } else {
        _remainingSeconds--;
        notifyListeners();
      }
    });
  }

  Future<void> resendCode(BuildContext context) async {
    if (!canResend) return;
    _startResendTimer();

    try {
      final response = await _api.resendCode(data: {'email': email});
      if (response['status'] == 'success') {
        AppSnackbar.show(
          context,
          message: response['message'] ?? 'Kode berhasil dikirim ulang',
          type: SnackBarType.success,
        );
      } else {
        AppSnackbar.show(
          context,
          message: response['message'] ?? 'Kode tidak berhasil dikirim ulang',
          type: SnackBarType.error,
        );
      }
    } on ApiException catch (e) {
      AppSnackbar.show(
        context,
        message: e.message,
        type: SnackBarType.error,
      );
    } catch (e) {
      AppSnackbar.show(
        context,
        message: '$e',
        type: SnackBarType.error,
      );
    }
  }

  void handleInputChange(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      FocusManager.instance.primaryFocus?.nextFocus();
    } else if (value.isEmpty && index > 0) {
      FocusManager.instance.primaryFocus?.previousFocus();
    }
  }

  void verifyOTP(BuildContext context) async {
    final code = otpControllers.map((c) => c.text).join();
    if (code.length == 6) {
      setLoading(true);
      try {
        final response = await _api.verifEmail(data: {
          'email': email,
          'code': code,
        });
        if (response['status'] == 'success') {
          AppDialog.show(
            context,
            title: response['status'],
            message: response['message'] ?? 'Verifikasi berhasil',
            type: DialogType.success,
            onConfirm: () {
              context.go('/login');
            },
          );
        } else {
          AppDialog.show(
            context,
            title: response['status'],
            message: response['message'] ?? 'Gagal Verifikasi',
            type: DialogType.error,
          );
        }
      } on ApiException catch (e) {
        AppDialog.show(
          context,
          title: 'Failed',
          message: e.message,
          type: DialogType.error,
        );
      } catch (e) {
        AppDialog.show(
          context,
          title: 'Failed',
          message: 'Verifikasi gagal: $e',
          type: DialogType.error,
        );
      }
    } else {
      AppSnackbar.show(
        context,
        message: 'Kode tidak lengkap',
        type: SnackBarType.error,
      );
    }
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    for (var c in otpControllers) {
      c.dispose();
    }
    super.dispose();
  }
}
