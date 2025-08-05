import 'package:app_riderguard/core/base/base_view.dart';
import 'package:app_riderguard/core/constants/colors_value.dart';
import 'package:app_riderguard/core/constants/fonts.dart';
import 'package:app_riderguard/core/utils/assets_helper.dart';
import 'package:app_riderguard/core/widget/base_container.dart';
import 'package:app_riderguard/module/general/viewModel/home_view_model.dart';
import 'package:app_riderguard/module/general/widget/app_bar_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, _) {
        return Scaffold(
          appBar: AppBarBase(
            title: "Dashboard",
            centerTitle: false,
            showBackButton: false,
            actions: [
              IconButton(
                  onPressed: () {
                    context.push('/notification');
                  },
                  icon: Icon(
                    Icons.notifications_active,
                  ))
            ],
          ),
          backgroundColor: ColorsValue.background,
          body: BaseContainer(
            isScrollable: true,
            showScrollbar: true,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Tanggal
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "AKTIVITAS HARI INI",
                          style: AppFonts.captionFont,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${model.dayNumber} ${model.monthYear}",
                          style: AppFonts.titleFont,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Persentase
                  Text(
                    model.progress,
                    style: AppFonts.displayFont.copyWith(
                      fontSize: 64.sp,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    "Target Harian Tercapai",
                    style: AppFonts.captionFont,
                  ),

                  SizedBox(height: 12.h),

                  // Animasi
                  InteractiveViewer(
                    panEnabled: true,
                    scaleEnabled: true,
                    child: SizedBox(
                      height: 200.h,
                      child: Lottie.asset(
                        AssetsHelper.introAnimation,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Statistik
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _StatItem(
                        icon: Icons.directions_bike,
                        color: Colors.indigo,
                        value: model.distance,
                        label: "Jarak Tempuh",
                      ),
                      _StatItem(
                        icon: Icons.timer,
                        color: Colors.teal,
                        value: model.duration,
                        label: "Durasi Tugas",
                      ),
                      _StatItem(
                        icon: Icons.bedtime,
                        color: Colors.blueAccent,
                        value: model.rest,
                        label: "Istirahat",
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  // ALERT / SAFETY BOX
                  if (model.alertMessage.isNotEmpty)
                    Container(
                      padding: EdgeInsets.all(14.r),
                      decoration: BoxDecoration(
                        color: Colors.yellow[100],
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: Colors.orangeAccent),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.warning, color: Colors.orange),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              model.alertMessage,
                              style: AppFonts.smallFont,
                            ),
                          ),
                        ],
                      ),
                    ),

                  SizedBox(height: 20.h),

                  // // Tombol Aksi Cepat
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     _QuickActionButton(
                  //         icon: Icons.play_arrow, label: "Mulai"),
                  //     _QuickActionButton(
                  //         icon: Icons.history, label: "Riwayat"),
                  //     _QuickActionButton(
                  //         icon: Icons.support_agent, label: "Bantuan"),
                  //   ],
                  // ),

                  SizedBox(height: 24.h),

                  // CARD INFO KESEHATAN
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            offset: Offset(0, 4)),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48.w,
                          height: 48.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: Colors.red.shade50,
                          ),
                          child: const Icon(Icons.health_and_safety,
                              color: Colors.red),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Tips Berkendara Aman",
                                style: AppFonts.buttonFont,
                              ),
                              Text(
                                "Dari Tim RiderGuard",
                                style: AppFonts.captionFont,
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String value;
  final String label;

  const _StatItem({
    required this.icon,
    required this.color,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ],
    );
  }
}
