import 'package:app_riderguard/core/networks/api_base.dart';
import 'package:app_riderguard/core/networks/api_endpoints.dart';

class AuthApi extends ApiBase {
  Future<Map> login({Map<String, dynamic>? data}) async {
    return await post(ApiEndpoints.login, data!, withAuth: false);
  }

  Future<Map> register({Map<String, dynamic>? data}) async {
    return await post(ApiEndpoints.register, data!, withAuth: false);
  }

  Future<Map> verifEmail({Map<String, dynamic>? data}) async {
    return await post(ApiEndpoints.verify, data!, withAuth: false);
  }

  Future<Map> resendCode({Map<String, dynamic>? data}) async {
    return await post(ApiEndpoints.login, data!, withAuth: false);
  }
}
