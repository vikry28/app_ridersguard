import 'package:app_riderguard/core/base/base_view.dart'
    show autoViewModelProvider;
import 'package:app_riderguard/module/general/viewModel/bottom_nav_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomNavBar extends ConsumerWidget {
  final Function(int) onTabSelected;

  const CustomBottomNavBar({super.key, required this.onTabSelected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel =
        ref.watch(autoViewModelProvider(() => BottomNavBarView()));

    return Container(
      height: 58.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32.r),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _navIcon(
                  icon: Icons.home,
                  index: 0,
                  viewModel: viewModel,
                  context: context),
              _navIcon(
                  icon: Icons.menu,
                  index: 1,
                  viewModel: viewModel,
                  context: context),
              SizedBox(width: 48.w),
              _navIcon(
                  icon: Icons.notifications_none,
                  index: 2,
                  viewModel: viewModel,
                  context: context),
              _navIcon(
                  icon: Icons.search,
                  index: 3,
                  viewModel: viewModel,
                  context: context),
            ],
          ),
          Positioned(
            top: -26.h,
            child: GestureDetector(
              onTap: () {
                viewModel.selectTab(context, 4);
                onTabSelected(4);
              },
              child: Container(
                height: 54.w,
                width: 54.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.pinkAccent, Colors.blueAccent],
                  ),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)],
                ),
                child: Icon(Icons.motorcycle, color: Colors.white, size: 28.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navIcon({
    required IconData icon,
    required int index,
    required BottomNavBarView viewModel,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () => viewModel.selectTab(context, index),
      child: Icon(
        icon,
        size: 22.sp,
        color: viewModel.selectedIndex == index ? Colors.black : Colors.grey,
      ),
    );
  }
}
