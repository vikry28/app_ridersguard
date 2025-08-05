// ignore_for_file: use_build_context_synchronously, strict_top_level_inference

import 'dart:convert';
import 'dart:io';
import 'package:app_riderguard/core/networks/api_base.dart';
import 'package:app_riderguard/core/utils/image_picker_util.dart';
import 'package:flutter/material.dart';
import 'package:app_riderguard/core/base/view_model_base.dart';
import 'package:app_riderguard/core/utils/logger.dart';
import 'package:app_riderguard/core/widget/app_dialog.dart';
import 'package:app_riderguard/module/user/profile/api/profile_api.dart';
import 'package:app_riderguard/module/user/profile/model/profile_model.dart';
import 'package:http/http.dart' as http;

class EditProfileViewModel extends ViewModelBase {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final addres = TextEditingController();
  String? imageUrl;
  final ProfileApi _api = ProfileApi();

  @override
  Future<void> init() async {
    setLoading(true);
    final profile = await _api.getProfiles();
    if (profile['status'] == 'success') {
      final data = ProfileModel.fromJson(profile['data']);
      name.text = data.name;
      email.text = data.email;
      phone.text = data.phone;
      addres.text = data.address;
      imageUrl = data.profileImage;
    }
    setLoading(false);
  }

  void updateProfile(BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        setLoading(true);
        final res = await _api.updateProfile({
          'name': name.text,
          'email': email.text,
          'phone': phone.text,
          'address': addres.text,
        });

        if (res['status'] == 'success') {
          AppDialog.show(
            context,
            title: 'Berhasil',
            message: res['message'] ?? 'Profil berhasil diperbarui',
            type: DialogType.success,
          );
        } else {
          AppDialog.show(
            context,
            title: 'Gagal',
            message: res['message'] ?? 'Gagal memperbarui profil',
            type: DialogType.error,
          );
        }
      } catch (e) {
        logger.e(e);
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

  void pickNewProfileImage(context) async {
    final file = await ImagePickerUtil.showImageSourceDialog(context);
    if (file != null) {
      uploadProfileImage(context, file);
    }
  }

  void uploadProfileImage(context, File file) async {
    try {
      setLoading(true);

      final streamedResponse = await _api.updatePhoto(file);
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
