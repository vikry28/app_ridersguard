import 'package:app_riderguard/core/utils/assets_helper.dart';
import 'package:app_riderguard/core/utils/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Inisialisasi animasi
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();
    _startApp();
  }

  Future<void> _startApp() async {
    final done = SharedPrefs.getString('onboarding_done') == 'true';
    await Future.delayed(const Duration(milliseconds: 2200));
    if (!mounted) return;
    if (done) {
      context.go('/login');
    } else {
      context.go('/onboarding');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AssetsHelper.logo,
                  width: 140,
                  height: 140,
                ),
                LottieBuilder.asset(
                  AssetsHelper.loading,
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                  repeat: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
