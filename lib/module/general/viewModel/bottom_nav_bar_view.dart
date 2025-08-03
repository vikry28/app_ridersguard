import 'package:app_riderguard/core/base/view_model_base.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavBarView extends ViewModelBase {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  final List<String> paths = [
    '/home',
    '/menu',
    '/search',
    '/profile',
    '/tengah',
  ];

  void selectTab(BuildContext context, int index) {
    if (_selectedIndex == index) return;
    _selectedIndex = index;
    notifyListeners();
    context.go(paths[index]);
  }

  @override
  Future<void> init() async {}
}
