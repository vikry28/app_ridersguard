import 'package:app_riderguard/module/general/view/home_view.dart';
import 'package:app_riderguard/module/general/view/bottom_nav_home_view.dart';
import 'package:app_riderguard/module/general/view/onboarding/onboarding_view.dart';
import 'package:app_riderguard/module/general/view/splash_view.dart';
import 'package:app_riderguard/module/user/auth/view/forgot_password_view.dart';
import 'package:app_riderguard/module/user/auth/view/login_view.dart';
import 'package:app_riderguard/module/user/auth/view/register_view.dart';
import 'package:app_riderguard/module/user/auth/view/verify_code_view.dart';
import 'package:app_riderguard/module/user/profile/view/profile_view.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingView(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterView(),
      ),
      GoRoute(
        path: '/ForgotPassword',
        builder: (context, state) => const ForgotPasswordView(),
      ),
      GoRoute(
        path: '/verify',
        builder: (context, state) {
          final email = state.extra as String;
          return VerifyCodeView(email: email);
        },
      ),
      ShellRoute(
        builder: (context, state, child) => BottomNavHomeView(child: child),
        routes: [
          GoRoute(path: '/home', builder: (context, state) => const HomeView()),
          GoRoute(
              path: '/menu',
              builder: (context, state) => const Text('Menu View')),
          GoRoute(
              path: '/search',
              builder: (context, state) => const Text('Menu View')),
          GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileView()),
          GoRoute(
              path: '/tengah',
              builder: (context, state) => const Text('Menu View')),
        
    GoRoute(
      path: '/user/setting',
      builder: (context, state) => const SettingView(),
    ),
],
      ),
    ],
  );
}
