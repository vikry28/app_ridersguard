import 'package:app_riderguard/core/base/view_model_base.dart';
import 'package:app_riderguard/core/utils/assets_helper.dart';
import 'package:app_riderguard/core/utils/extensions.dart';
import 'package:app_riderguard/core/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingViewModel extends ViewModelBase {
  final PageController pageController = PageController();
  int currentPage = 0;

  List<Map<String, String>> getOnboardingData(BuildContext context) {
    return [
      {
        "image": AssetsHelper.onboarding1,
        "title": context.tr("onboarding_title_1"),
        "subtitle": context.tr("onboarding_subtitle_1"),
      },
      {
        "image": AssetsHelper.onboarding2,
        "title": context.tr("onboarding_title_2"),
        "subtitle": context.tr("onboarding_subtitle_2"),
      },
      {
        "image": AssetsHelper.onboarding3,
        "title": context.tr("onboarding_title_3"),
        "subtitle": context.tr("onboarding_subtitle_3"),
      },
    ];
  }

  void onPageChanged(int index) {
    currentPage = index;
    notifyListeners();
  }

  Future<void> onNextPressed(BuildContext context) async {
    if (currentPage == getOnboardingData(context).length - 1) {
      await skipOnboarding(context);
    } else {
      currentPage++;
      notifyListeners();
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  Future<void> skipOnboarding(BuildContext context) async {
    await SharedPrefs.setString('onboarding_done', 'true');
    // ignore: use_build_context_synchronously
    context.go('/login');
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
