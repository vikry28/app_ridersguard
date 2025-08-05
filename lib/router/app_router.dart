import 'package:app_riderguard/module/general/view/home_view.dart';
import 'package:app_riderguard/module/general/view/bottom_nav_home_view.dart';
import 'package:app_riderguard/module/general/view/notification_view.dart';
import 'package:app_riderguard/module/general/view/onboarding_view.dart';
import 'package:app_riderguard/module/general/view/splash_view.dart';
import 'package:app_riderguard/module/user/auth/view/forgot_password_view.dart';
import 'package:app_riderguard/module/user/auth/view/login_view.dart';
import 'package:app_riderguard/module/user/auth/view/register_view.dart';
import 'package:app_riderguard/module/user/auth/view/verify_code_view.dart';
import 'package:app_riderguard/module/user/profile/view/edit_profile_view.dart';
import 'package:app_riderguard/module/user/profile/view/profile_view.dart';
import 'package:app_riderguard/module/user/profile/view/user_info_view.dart';
import 'package:app_riderguard/module/user/setting/view/appversion_view.dart';
import 'package:app_riderguard/module/user/setting/view/biometric_settings_view.dart';
import 'package:app_riderguard/module/user/setting/view/faq_view.dart';
import 'package:app_riderguard/module/user/setting/view/language_settings_view.dart';
import 'package:app_riderguard/module/user/setting/view/notification_settings_view.dart';
import 'package:app_riderguard/module/user/setting/view/privacy_policy_view.dart';
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
      GoRoute(
        path: '/profile/user_info',
        builder: (context, state) => const UserInfoView(),
      ),
      GoRoute(
        path: '/profile/edit_profile',
        builder: (context, state) => const EditProfileView(),
      ),
      GoRoute(
        path: '/notification',
        builder: (context, state) => const NotificationView(),
      ),
      GoRoute(
        path: '/setting/notification',
        builder: (context, state) => const NotificationSettingsView(),
      ),
      GoRoute(
        path: '/settings/biometric',
        builder: (context, state) => const BiometricSettingsView(),
      ),
      GoRoute(
        path: '/settings/language',
        builder: (context, state) => const LanguageSettingsView(),
      ),
      GoRoute(
        path: '/setting/privacy',
        builder: (context, state) => const PrivacyPolicyView(),
      ),
      GoRoute(
        path: '/setting/faq',
        builder: (context, state) => const FaqView(),
      ),
      GoRoute(
        path: '/setting/app_version',
        builder: (context, state) => const AppVersionView(),
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
        ],
      ),
    ],
  );
}
