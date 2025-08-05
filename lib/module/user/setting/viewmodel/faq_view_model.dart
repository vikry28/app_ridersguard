import 'package:app_riderguard/core/base/view_model_base.dart';
import 'package:app_riderguard/core/utils/extensions.dart';
import 'package:app_riderguard/module/user/setting/model/faq_item.dart';
import 'package:flutter/widgets.dart';

class FaqViewModel extends ViewModelBase {
  List<FaqItem> _faqList = [];
  List<FaqItem> get faqList => _faqList;

  Future<void> initWithContext(BuildContext context) async {
    _faqList = [
      FaqItem(
        question: context.tr('faq_1_question'),
        answer: context.tr('faq_1_answer'),
      ),
      FaqItem(
        question: context.tr('faq_2_question'),
        answer: context.tr('faq_2_answer'),
      ),
      FaqItem(
        question: context.tr('faq_3_question'),
        answer: context.tr('faq_3_answer'),
      ),
    ];
    notifyListeners();
  }
}
