import 'package:app_riderguard/core/base/base_view.dart';
import 'package:app_riderguard/core/constants/fonts.dart';
import 'package:app_riderguard/module/general/viewModel/onboarding_view_model.dart';
import 'package:app_riderguard/module/general/widget/custom_circular_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<OnboardingViewModel>(
      viewModelBuilder: () => OnboardingViewModel(),
      builder: (context, model, ref) {
        return Scaffold(
          body: PageView.builder(
            controller: model.pageController,
            itemCount: model.getOnboardingData(context).length,
            onPageChanged: model.onPageChanged,
            itemBuilder: (context, index) {
              final data = model.getOnboardingData(context)[index];
              return OnboardingPage(
                image: data['image']!,
                title: data['title']!,
                subtitle: data['subtitle']!,
                onNext: () => model.onNextPressed(context),
                currentIndex: model.currentPage,
                totalPage: model.getOnboardingData(context).length,
              );
            },
          ),
        );
      },
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final VoidCallback onNext;
  final int currentIndex;
  final int totalPage;

  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.onNext,
    required this.currentIndex,
    required this.totalPage,
  });

  @override
  Widget build(BuildContext context) {
    double progress = (currentIndex + 1) / totalPage;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Image.asset(
              image,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 24.w),
          Text(
            title,
            style: AppFonts.titleFont,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12.w),
          Text(
            subtitle,
            style: AppFonts.subtitleFont,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40.w),
          CustomCircularButton(
            onPressed: onNext,
            progress: progress,
          ),
        ],
      ),
    );
  }
}
