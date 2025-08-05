import 'package:app_riderguard/core/base/view_model_base.dart';
import 'package:app_riderguard/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PrivacyPolicyViewModel extends ViewModelBase {
  List<Map<String, String>> sections = [];

  Future<void> loadLocalizedSections(BuildContext context) async {
    sections = [
      {
        'title': context.tr('privacy_title_1'),
        'body': context.tr('privacy_body_1'),
      },
      {
        'title': context.tr('privacy_title_2'),
        'body': context.tr('privacy_body_2'),
      },
      {
        'title': context.tr('privacy_title_3'),
        'body': context.tr('privacy_body_3'),
      },
    ];
    notifyListeners();
  }
}
