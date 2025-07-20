import 'package:app_riderguard/core/networks/api_base.dart';

class ApiGeneral extends ApiBase {
  Future<Map> generalInfo() async {
    return await get('/general/info', withAuth: false);
  }
}
