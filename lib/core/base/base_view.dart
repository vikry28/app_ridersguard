import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_riderguard/core/widget/app_loading.dart';
import 'view_model_base.dart';

class BaseView<T extends ViewModelBase> extends ConsumerStatefulWidget {
  final T Function() viewModelBuilder;
  final void Function(T viewModel)? onModelReady;
  final Widget Function(BuildContext context, T viewModel, WidgetRef ref)
      builder;

  const BaseView({
    super.key,
    required this.viewModelBuilder,
    this.onModelReady,
    required this.builder,
  });

  @override
  ConsumerState<BaseView<T>> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends ViewModelBase>
    extends ConsumerState<BaseView<T>> {
  late final AutoDisposeChangeNotifierProvider<T> provider;

  @override
  void initState() {
    super.initState();
    provider = ChangeNotifierProvider.autoDispose<T>((ref) {
      return widget.viewModelBuilder();
    });

    Future.microtask(() async {
      final viewModel = ref.read(provider);
      if (!viewModel.isInitialized) {
        await viewModel.init();
        widget.onModelReady?.call(viewModel);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(provider);

    return LoadingOverlay(
      isLoading: viewModel.isLoading,
      child: widget.builder(context, viewModel, ref),
    );
  }
}
