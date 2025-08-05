import 'package:app_riderguard/core/base/base_view.dart';
import 'package:app_riderguard/core/constants/colors_value.dart';
import 'package:app_riderguard/core/constants/fonts.dart';
import 'package:app_riderguard/core/utils/extensions.dart';
import 'package:app_riderguard/core/widget/base_container.dart';
import 'package:app_riderguard/module/general/model/notification_item.dart';
import 'package:app_riderguard/module/general/viewModel/notification_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:app_riderguard/module/general/widget/app_bar_base.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<NotificationViewModel>(
      viewModelBuilder: () => NotificationViewModel(),
      onModelReady: (vm) => vm.init(),
      builder: (context, vm, _) {
        return Scaffold(
          appBar: AppBarBase(
            title: context.tr('notification'),
            centerTitle: false,
          ),
          backgroundColor: ColorsValue.background,
          body: BaseContainer(
            isScrollable: false,
            padding: EdgeInsets.zero,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              itemCount: vm.groupedNotifications.length,
              itemBuilder: (context, index) {
                final section =
                    vm.groupedNotifications.entries.elementAt(index);
                final notifications = section.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: index > 0 ? 24.h : 12.h,
                        bottom: 12.h,
                        left: 16.w,
                        right: 16.w,
                      ),
                      child: Text(
                        section.key,
                        style: AppFonts.titleFont.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ...List.generate(notifications.length, (i) {
                      final notif = notifications[i];
                      return Column(
                        children: [
                          _buildNotificationTile(notif),
                          if (i < notifications.length - 1)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Divider(
                                color: Colors.grey.shade300,
                                height: 1.h,
                                thickness: 1,
                              ),
                            ),
                        ],
                      );
                    }),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildNotificationTile(NotificationItem notif) {
    return Container(
      width: double.infinity,
      color: notif.isRead ? ColorsValue.background : const Color(0xFFEAF4FF),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 17.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(6.r),
                  decoration: const BoxDecoration(
                    color: Color(0xFFD2EBFF),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.notifications_none,
                      color: Colors.blue, size: 20.r),
                ),
                if (!notif.isRead)
                  Positioned(
                    top: 0,
                    right: 0,
                    child:
                        Icon(Icons.circle, size: 8.r, color: Colors.redAccent),
                  ),
              ],
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notif.title,
                    style: AppFonts.subtitleFont.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    notif.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppFonts.captionFont.copyWith(
                      fontSize: 12.sp,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('dd-MM-yyyy').format(notif.date),
                        style: AppFonts.smallFont.copyWith(
                          color: Colors.grey.shade600,
                          fontSize: 11.sp,
                        ),
                      ),
                      Text(
                        DateFormat('HH:mm').format(notif.date),
                        style: AppFonts.smallFont.copyWith(
                          color: Colors.grey.shade600,
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
