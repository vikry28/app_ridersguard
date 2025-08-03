import '../model/setting_model.dart';
import 'package:app_riderguard/core/networks/api_base.dart';

class SettingApi extends ApiBase {
  Future<List<SettingModel>> fetchSettings() async {
    await Future.delayed(const Duration(seconds: 1));
    return [SettingModel(id: 1, name: 'Contoh')];
  }
}
