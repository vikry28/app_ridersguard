import 'dart:convert';
import 'package:app_riderguard/core/base/view_model_base.dart';
import 'package:app_riderguard/core/networks/api_base.dart';
import 'package:app_riderguard/core/utils/logger.dart';
import 'package:app_riderguard/core/widget/app_dialog.dart';
import 'package:app_riderguard/module/user/profile/api/profile_api.dart';
import 'package:app_riderguard/core/utils/image_picker_util.dart';
import 'dart:io';
import 'package:app_riderguard/module/user/profile/model/profile_model.dart';
import 'package:http/http.dart' as http;

class UserInfoViewModel extends ViewModelBase {
  final ProfileApi api = ProfileApi();
  ProfileModel? profile;
  ProfileModel? get user => profile;

  @override
  Future<void> init() async {
    getProfile();
  }

  void getProfile() async {
    try {
      setLoading(true);
      final Map response = await api.getProfiles();
      if (response['status'] == 'success' && response['data'] != null) {
        profile = ProfileModel.fromJson(response['data']);
      } else {
        profile = null;
      }
    } catch (e) {
      logger.e(e);
    } finally {
      setLoading(false);
    }
  }

  // ignore: strict_top_level_inference
  void pickNewProfileImage(context) async {
    final file = await ImagePickerUtil.showImageSourceDialog(context);
    if (file != null) {
      uploadProfileImage(context, file);
    }
  }

  // ignore: strict_top_level_inference
  void uploadProfileImage(context, File file) async {
    try {
      setLoading(true);

      final streamedResponse = await api.updatePhoto(file);
      final response = await http.Response.fromStream(streamedResponse);

      final parsed = jsonDecode(response.body);

      final status = parsed['status'];
      final message = parsed['message'] ?? 'Foto berhasil diperbarui.';

      if (status == 'success') {
        AppDialog.show(
          context,
          title: 'Berhasil',
          message: message,
          type: DialogType.success,
        );
      } else {
        AppDialog.show(
          context,
          title: 'Gagal Upload',
          message: message,
          type: DialogType.error,
        );
      }
    } on ApiException catch (e) {
      AppDialog.show(
        context,
        title: 'Upload Gagal',
        message: e.message,
        type: DialogType.error,
      );
    } catch (e) {
      AppDialog.show(
        context,
        title: 'Terjadi Kesalahan',
        message: '$e',
        type: DialogType.error,
      );
    } finally {
      setLoading(false);
    }
  }
}
