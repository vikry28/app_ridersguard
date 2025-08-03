import 'package:flutter/material.dart';
import 'package:app_riderguard/core/base/base_view.dart';
import '../viewmodel/setting_view_model.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<SettingViewModel>(
      viewModelBuilder: () => SettingViewModel(),
      onModelReady: (vm) => vm.init(),
      builder: (context, viewModel, ref) {
        return Scaffold(
          appBar: AppBar(title: const Text('Setting')),
          body: const Center(child: Text('Setting Page')),
        );
      },
    );
  }
}
