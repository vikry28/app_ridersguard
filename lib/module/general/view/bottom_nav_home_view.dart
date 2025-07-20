import 'package:app_riderguard/core/base/base_view.dart';
import 'package:app_riderguard/module/general/viewModel/widget/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import '../viewModel/bottom_nav_bar_view.dart';

class BottomNavHomeView extends StatelessWidget {
  final Widget child;

  const BottomNavHomeView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BaseView<BottomNavBarView>(
      viewModelBuilder: () => BottomNavBarView(),
      onModelReady: (vm) => vm.init(),
      builder: (context, viewModel, ref) {
        return Scaffold(
          body: child,
          bottomNavigationBar: CustomBottomNavBar(
            onTabSelected: (i) => viewModel.selectTab(context, i),
          ),
        );
      },
    );
  }
}
