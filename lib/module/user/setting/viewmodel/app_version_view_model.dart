import 'package:app_riderguard/core/base/view_model_base.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersionViewModel extends ViewModelBase {
  String? version;

  @override
  Future<void> init() async {
    getAppVersion();
  }

  void getAppVersion() async {
    try {
      final info = await PackageInfo.fromPlatform();
      version = '${info.version} (${info.buildNumber})';
      notifyListeners();
    } catch (e) {
      version = 'Unknown';
    }
  }
}
