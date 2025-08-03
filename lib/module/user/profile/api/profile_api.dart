import 'dart:io';
import 'package:app_riderguard/core/networks/api_base.dart';
import 'package:app_riderguard/core/networks/api_endpoints.dart';
// ignore: implementation_imports
import 'package:http/src/streamed_response.dart';

class ProfileApi extends ApiBase {
  Future<Map> getProfiles() async {
    return await get(ApiEndpoints.getMe, withAuth: true);
  }

  Future<StreamedResponse> updatePhoto(File file) async {
    return await putMultipart(
      ApiEndpoints.updateFoto,
      {},
      file,
      fileField: 'image',
      withAuth: true,
    );
  }

  Future<Map> logout() async {
    return await post(ApiEndpoints.logout, {}, withAuth: true);
  }
}
