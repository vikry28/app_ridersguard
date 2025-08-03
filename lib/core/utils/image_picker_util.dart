// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_riderguard/core/constants/colors_value.dart';
import 'package:app_riderguard/core/constants/fonts.dart';
import 'package:app_riderguard/core/utils/extensions.dart';
import 'package:path/path.dart' as path;

class ImagePickerUtil {
  static final ImagePicker _picker = ImagePicker();

  static Future<File?> pickFromGallery() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  static Future<File?> pickFromCamera() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);
    return pickedFile != null ? File(pickedFile.path) : null;
  }

  static Future<File?> showImageSourceDialog(BuildContext context) async {
    File? selectedImage;

    return showDialog<File>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          titlePadding:
              EdgeInsets.only(top: 16.h, left: 20.w, right: 12.w, bottom: 0),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  context.tr('select_image_source'),
                  style: AppFonts.titleFont.copyWith(fontSize: 18.sp),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).maybePop();
                },
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (selectedImage != null) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 180.h,
                      child: Stack(
                        children: [
                          Image.file(
                            selectedImage!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                          Positioned(
                            top: 8.h,
                            right: 8.w,
                            child: GestureDetector(
                              onTap: () => setState(() => selectedImage = null),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.black45,
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(4.w),
                                child: Icon(
                                  Icons.close,
                                  size: 18.w,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    path.basename(selectedImage!.path),
                    style: AppFonts.captionFont.copyWith(fontSize: 12.sp),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                ],
                _dialogOption(
                  icon: Icons.photo_library_outlined,
                  label: context.tr('choose_from_gallery'),
                  onTap: () async {
                    final image = await pickFromGallery();
                    if (image != null) {
                      setState(() => selectedImage = image);
                    }
                  },
                ),
                SizedBox(height: 8.h),
                _dialogOption(
                  icon: Icons.camera_alt_outlined,
                  label: context.tr('take_from_camera'),
                  onTap: () async {
                    final image = await pickFromCamera();
                    if (image != null) {
                      setState(() => selectedImage = image);
                    }
                  },
                ),
                if (selectedImage != null) ...[
                  SizedBox(height: 20.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsValue.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true)
                            .pop(selectedImage);
                      },
                      child: Text(
                        context.tr('confirm'),
                        style:
                            AppFonts.buttonFont.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _dialogOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? color,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
        child: Row(
          children: [
            Icon(icon, color: color ?? Colors.blue, size: 22.w),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                label,
                style: AppFonts.bodyFont.copyWith(fontSize: 14.sp),
              ),
            )
          ],
        ),
      ),
    );
  }
}
