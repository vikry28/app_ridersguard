import 'package:app_riderguard/core/base/view_model_base.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class VerifyCodeViewModel extends ViewModelBase {
  final String email;
  final List<TextEditingController> otpControllers =
      List.generate(6, (_) => TextEditingController());

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

  void resendCode() {
    _startResendTimer();
  }

  void handleInputChange(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      FocusManager.instance.primaryFocus?.nextFocus();
    } else if (value.isEmpty && index > 0) {
      FocusManager.instance.primaryFocus?.previousFocus();
    }
  }

  void verifyOTP(BuildContext context) {
    final code = otpControllers.map((c) => c.text).join();
    if (code.length == 6) {
      debugPrint('Verifying code: $code');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kode tidak lengkap')),
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
