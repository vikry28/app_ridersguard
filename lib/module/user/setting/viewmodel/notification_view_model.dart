import 'package:app_riderguard/core/base/view_model_base.dart';
import 'package:app_riderguard/core/utils/shared_prefs.dart';

class NotificationSettingsViewModel extends ViewModelBase {
  bool pushEnabled = false;
  bool emailEnabled = false;

  @override
  Future<void> init() async {
    pushEnabled = SharedPrefs.getBool('notif_push') ?? false;
    emailEnabled = SharedPrefs.getBool('notif_email') ?? false;
    notifyListeners();
  }

  Future<void> togglePush(bool value) async {
    pushEnabled = value;
    await SharedPrefs.setBool('notif_push', value);
    notifyListeners();
  }

  Future<void> toggleEmail(bool value) async {
    emailEnabled = value;
    await SharedPrefs.setBool('notif_email', value);
    notifyListeners();
  }
}
