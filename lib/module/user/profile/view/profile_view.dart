import 'package:app_riderguard/core/constants/colors_value.dart';
import 'package:app_riderguard/core/constants/fonts.dart';
import 'package:app_riderguard/core/utils/date_utils.dart';
import 'package:app_riderguard/core/utils/extensions.dart';
import 'package:app_riderguard/core/widget/base_container.dart';
import 'package:app_riderguard/core/widget/profile_avatar.dart';
import 'package:app_riderguard/core/widget/profile_item_swith.dart';
import 'package:app_riderguard/core/widget/view_image.dart';
import 'package:app_riderguard/module/general/widget/app_bar_base.dart';
import 'package:flutter/material.dart';
import 'package:app_riderguard/core/base/base_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../viewmodel/profile_view_model.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
      viewModelBuilder: () => ProfileViewModel(),
      onModelReady: (vm) => vm.init(),
      builder: (context, viewModel, ref) {
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
                  context.tr('profile'),
                  style:
                      AppFonts.bodyFont.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12.h),
                ProfileItem(
                  icon: Icons.person_outline,
                  label: context.tr('manage_user'),
                  onTap: () {},
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
                  onTap: () {},
                ),
                SizedBox(height: 12.h),
                ProfileItemSwitch(
                  icon: Icons.dark_mode_outlined,
                  label: context.tr('dark_mode'),
                  value: false,
                  onChanged: (val) => (val),
                ),
                ProfileItem(
                  icon: Icons.fingerprint,
                  label: context.tr('biometrics'),
                  onTap: () {},
                ),
                SizedBox(height: 12.h),
                ProfileItem(
                  icon: Icons.language,
                  label: context.tr('language'),
                  onTap: () {},
                ),
                SizedBox(height: 12.h),
                ProfileItem(
                  icon: Icons.lock_outline,
                  label: context.tr('privacy_policy'),
                  onTap: () {},
                ),
                SizedBox(height: 12.h),
                ProfileItem(
                  icon: Icons.help_outline,
                  label: context.tr('faq'),
                  onTap: () {},
                ),
                ProfileItem(
                  icon: Icons.info_outline,
                  label: context.tr('app_version'),
                  trailingText: viewModel.version ?? '-',
                  showArrow: false,
                  onTap: null,
                ),
                SizedBox(height: 12.h),
                ProfileItem(
                  icon: Icons.logout_outlined,
                  label: context.tr('logout'),
                  onTap: () => viewModel.logoutUser(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
