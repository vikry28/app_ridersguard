import 'package:app_riderguard/core/widget/view_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_riderguard/core/base/base_view.dart';
import 'package:app_riderguard/core/constants/colors_value.dart';
import 'package:app_riderguard/core/utils/extensions.dart';
import 'package:app_riderguard/core/widget/base_container.dart';
import 'package:app_riderguard/core/widget/custom_text_field.dart';
import 'package:app_riderguard/core/widget/custom_button.dart';
import 'package:app_riderguard/core/widget/profile_avatar.dart';
import 'package:app_riderguard/module/general/widget/app_bar_base.dart';
import 'package:app_riderguard/module/user/profile/viewmodel/edit_profile_view_model.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<EditProfileViewModel>(
      viewModelBuilder: () => EditProfileViewModel(),
      onModelReady: (vm) => vm.init(),
      builder: (context, vm, ref) {
        return Scaffold(
          backgroundColor: ColorsValue.background,
          appBar: AppBarBase(
            title: context.tr('edit_profile'),
            centerTitle: false,
          ),
          body: BaseContainer(
            isScrollable: true,
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      ProfileAvatar(
                        imageUrl: vm.imageUrl,
                        onTap: () {
                          final imageUrl = vm.imageUrl ?? '';
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
                    ],
                  ),
                ),
                SizedBox(height: 28.h),
                Form(
                  key: vm.formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        label: context.tr('name'),
                        controller: vm.name,
                        isValid: true,
                        // validatorType: StringValidatorType.name,
                        prefixIcon: const Icon(Icons.person_outline),
                      ),
                      SizedBox(height: 12.h),
                      CustomTextField(
                        label: context.tr('email'),
                        controller: vm.email,
                        isValid: true,
                        keyboardType: TextInputType.emailAddress,
                        validatorType: StringValidatorType.email,
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                      SizedBox(height: 12.h),
                      CustomTextField(
                        label: context.tr('phone'),
                        controller: vm.phone,
                        isValid: true,
                        keyboardType: TextInputType.phone,
                        prefixIcon: const Icon(Icons.phone_outlined),
                      ),
                      SizedBox(height: 12.h),
                      CustomTextField(
                        label: context.tr('address'),
                        controller: vm.addres,
                        isValid: true,
                        keyboardType: TextInputType.streetAddress,
                        prefixIcon: const Icon(Icons.home_outlined),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),
                CustomButton(
                  label: context.tr('save'),
                  onPressed: () => vm.updateProfile(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
