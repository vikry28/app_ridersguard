import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileAvatar extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;

  const ProfileAvatar({
    super.key,
    required this.imageUrl,
    this.radius = 40,
    this.onTap,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl != null && imageUrl!.isNotEmpty;
    final imageProvider = hasImage ? NetworkImage(imageUrl!) : null;

    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
            radius: radius.r,
            backgroundColor: Colors.grey.shade200,
            backgroundImage: imageProvider,
            child: !hasImage
                ? Icon(
                    Icons.person,
                    size: radius.r,
                    color: Colors.grey.shade500,
                  )
                : null,
          ),
        ),
        Positioned(
          bottom: 4.h,
          right: 4.w,
          child: InkWell(
            onTap: onEdit,
            borderRadius: BorderRadius.circular(20.r),
            child: Container(
              padding: EdgeInsets.all(4.r),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 2.r,
                  ),
                ],
              ),
              child: Icon(
                Icons.camera_alt,
                size: 16.sp,
                color: Colors.blueGrey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
