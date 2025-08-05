import 'package:app_riderguard/core/base/base_view.dart';
import 'package:app_riderguard/core/constants/colors_value.dart';
import 'package:app_riderguard/core/constants/fonts.dart';
import 'package:app_riderguard/core/utils/extensions.dart';
import 'package:app_riderguard/core/widget/base_container.dart';
import 'package:app_riderguard/core/widget/profile_avatar.dart';
import 'package:app_riderguard/core/widget/view_image.dart';
import 'package:app_riderguard/module/general/widget/app_bar_base.dart';
import 'package:app_riderguard/module/user/profile/viewmodel/user_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class UserInfoView extends StatelessWidget {
  const UserInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<UserInfoViewModel>(
      viewModelBuilder: () => UserInfoViewModel(),
      onModelReady: (vm) => vm.init(),
      builder: (context, vm, ref) {
        return Scaffold(
          appBar: AppBarBase(
            title: context.tr('user_info'),
            centerTitle: false,
            actions: [
              IconButton(
                  onPressed: () => context.push('/profile/edit_profile'),
                  icon: Icon(
                    Icons.edit_document,
                    size: 20.sp,
                    // color: ColorsValue.alertGren,
                  ))
            ],
          ),
          backgroundColor: ColorsValue.background,
          body: BaseContainer(
            isScrollable: true,
            showScrollbar: true,
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      ProfileAvatar(
                        imageUrl: vm.profile?.profileImage,
                        onTap: () {
                          final imageUrl = vm.profile?.profileImage ?? '';
                          if (imageUrl.isNotEmpty) {
                            showViewImageDialog(
                              context: context,
                              image: imageUrl,
                              sourceType: ImageSourceType.network,
                            );
                          }
                        },
                        onEdit: () => vm.pickNewProfileImage(context),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        vm.profile?.name ?? '',
                        style: AppFonts.titleFont.copyWith(fontSize: 18.sp),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        vm.profile?.username ?? '',
                        style: AppFonts.captionFont,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 28.h),

                // Informasi
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    context.tr('user_info'),
                    style: AppFonts.titleFont.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                _infoItem(
                  title: context.tr('fullname'),
                  value: vm.profile?.name ?? '',
                ),
                SizedBox(height: 12.h),
                _infoItem(
                  title: context.tr('username'),
                  value: vm.profile?.username ?? '',
                ),
                SizedBox(height: 12.h),
                _infoItem(
                  title: 'Email',
                  value: vm.profile?.email ?? '',
                  icon: vm.profile?.isVerified ?? false
                      ? const Icon(Icons.verified,
                          color: Colors.green, size: 18)
                      : const Icon(Icons.error_outline,
                          color: Colors.grey, size: 18),
                ),
                SizedBox(height: 12.h),
                _infoItem(
                  title: context.tr('phone'),
                  value: vm.profile?.phone ?? '-',
                ),
                SizedBox(height: 12.h),
                _infoItem(
                  title: context.tr('address'),
                  value: vm.profile?.address ?? '-',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _infoItem({
    required String title,
    required String value,
    Widget? icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppFonts.captionFont.copyWith(color: Colors.grey)),
        SizedBox(height: 4.h),
        Row(
          children: [
            Expanded(
              child: Text(value, style: AppFonts.bodyFont),
            ),
            if (icon != null) icon,
          ],
        ),
      ],
    );
  }
}
