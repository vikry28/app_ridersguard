import 'package:app_riderguard/core/networks/api_base.dart';
import 'package:app_riderguard/core/networks/api_endpoints.dart';

class AuthApi extends ApiBase {
  Future<Map> login({Map<String, dynamic>? data}) async {
    return await post(ApiEndpoints.login, data!, withAuth: false);
  }
}
