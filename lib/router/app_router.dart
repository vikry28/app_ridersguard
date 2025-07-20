import 'package:app_riderguard/module/general/view/home_view.dart';
import 'package:app_riderguard/module/general/view/bottom_nav_home_view.dart';
import 'package:app_riderguard/module/general/view/splash_view.dart';
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
      ShellRoute(
        builder: (context, state, child) => BottomNavHomeView(child: child),
        routes: [
          GoRoute(path: '/home', builder: (context, state) => const HomeView()),
          GoRoute(
              path: '/menu',
              builder: (context, state) => const Text('Menu View')),
          GoRoute(
              path: '/notifikasi',
              builder: (context, state) => const Text('Menu View')),
          GoRoute(
              path: '/pencarian',
              builder: (context, state) => const Text('Menu View')),
          GoRoute(
              path: '/tengah',
              builder: (context, state) => const Text('Menu View')),
        ],
      ),
    ],
  );
}
