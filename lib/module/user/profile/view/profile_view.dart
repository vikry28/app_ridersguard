import 'package:app_riderguard/core/constants/colors_value.dart';
import 'package:app_riderguard/core/constants/fonts.dart';
import 'package:app_riderguard/core/utils/date_utils.dart';
import 'package:app_riderguard/core/utils/extensions.dart';
import 'package:app_riderguard/core/widget/base_container.dart';
import 'package:app_riderguard/core/widget/custom_button.dart';
import 'package:app_riderguard/core/widget/profile_avatar.dart';
import 'package:app_riderguard/core/widget/profile_item_swith.dart';
import 'package:app_riderguard/core/widget/view_image.dart';
import 'package:app_riderguard/module/general/widget/app_bar_base.dart';
import 'package:flutter/material.dart';
import 'package:app_riderguard/core/base/base_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../viewmodel/profile_view_model.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
      viewModelBuilder: () => ProfileViewModel(),
      onModelReady: (vm) => vm.init(),
      builder: (c, viewModel, ref) {
        return Scaffold(
          appBar: AppBarBase(
            title: context.tr('profile'),
            centerTitle: false,
            showBackButton: false,
          ),
          backgroundColor: ColorsValue.background,
          body: BaseContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ProfileAvatar(
                      imageUrl: viewModel.profile?.profileImage,
                      onTap: () {
                        final imageUrl = viewModel.profile?.profileImage ?? '';
                        if (imageUrl.isNotEmpty) {
                          showViewImageDialog(
                            context: context,
                            image: imageUrl,
                            sourceType: ImageSourceType.network,
                          );
                        }
                      },
                      onEdit: () => viewModel.pickNewProfileImage(context),
                    ),
                    SizedBox(width: 16.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(viewModel.profile?.name ?? '',
                            style: AppFonts.subtitleFont),
                        Text(viewModel.profile?.email ?? '',
                            style: AppFonts.smallFont
                                .copyWith(color: Colors.grey)),
                        SizedBox(height: 8.h),
                        Text(
                          '${context.tr('joined')} \n${AppDateUtils.joinedAgo(context, viewModel.profile?.createdAt ?? DateTime.now())}',
                          style:
                              AppFonts.captionFont.copyWith(color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 32.h),
                Text(
                  context.tr('account'),
                  style:
                      AppFonts.bodyFont.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12.h),
                ProfileItem(
                  icon: Icons.person_outline,
                  label: context.tr('user_info'),
                  onTap: () => context.push('/profile/user_info'),
                ),
                SizedBox(height: 24.h),
                Text(
                  context.tr('settings'),
                  style:
                      AppFonts.bodyFont.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12.h),
                ProfileItem(
                  icon: Icons.notifications_none,
                  label: context.tr('notifications'),
                  onTap: () => context.push('/setting/notification'),
                ),
                SizedBox(height: 12.h),
                ProfileItemSwitch(
                  icon: Icons.dark_mode_outlined,
                  label: context.tr('dark_mode'),
                  value: false,
                  onChanged: (val) => (val),
                ),
                SizedBox(height: 12.h),
                ProfileItem(
                  icon: Icons.fingerprint,
                  label: context.tr('biometrics'),
                  onTap: () => context.push('/settings/biometric'),
                ),
                SizedBox(height: 12.h),
                ProfileItem(
                  icon: Icons.language,
                  label: context.tr('language'),
                  onTap: () => context.push('/settings/language'),
                ),
                SizedBox(height: 12.h),
                ProfileItem(
                  icon: Icons.lock_outline,
                  label: context.tr('privacy_policy'),
                  onTap: () => context.push('/setting/privacy'),
                ),
                SizedBox(height: 12.h),
                ProfileItem(
                  icon: Icons.help_outline,
                  label: context.tr('faq'),
                  onTap: () => context.push('/setting/faq'),
                ),
                SizedBox(height: 12.h),
                ProfileItem(
                  icon: Icons.info_outline,
                  label: context.tr('app_version'),
                  trailingText: viewModel.version ?? '-',
                  showArrow: false,
                  onTap: () => context.push('/setting/app_version'),
                ),
                SizedBox(height: 20.h),
                CustomButton(
                  label: context.tr('logout'),
                  onPressed: () => viewModel.logoutUser(context),
                ),
                SizedBox(height: 20.h),
                // ProfileItem(
                //   icon: Icons.logout_outlined,
                //   label: context.tr('logout'),
                //   onTap: () => viewModel.logoutUser(context),
                //   showArrow: false,
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
