import 'package:app_riderguard/core/base/view_model_base.dart';
import 'package:app_riderguard/core/utils/shared_prefs.dart';
import 'package:local_auth/local_auth.dart';

class BiometricSettingsViewModel extends ViewModelBase {
  final LocalAuthentication _auth = LocalAuthentication();

  bool isBiometricSupported = false;
  bool isBiometricEnabled = false;

  @override
  Future<void> init() async {
    isBiometricSupported = await _auth.isDeviceSupported();
    isBiometricEnabled = SharedPrefs.getBool('biometric_enabled') ?? false;
    notifyListeners();
  }

  Future<void> toggleBiometric(bool enabled) async {
    isBiometricEnabled = enabled;
    await SharedPrefs.setBool('biometric_enabled', enabled);
    notifyListeners();
  }
}
