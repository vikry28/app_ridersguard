import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'view_model_base.dart';

final _viewModelProviderMap =
    <Type, AutoDisposeChangeNotifierProvider<ViewModelBase>>{};

AutoDisposeChangeNotifierProvider<T>
    autoViewModelProvider<T extends ViewModelBase>(T Function() creator) {
  if (_viewModelProviderMap[T] == null) {
    _viewModelProviderMap[T] =
        ChangeNotifierProvider.autoDispose<T>((ref) => creator())
            as AutoDisposeChangeNotifierProvider<ViewModelBase>;
  }
  return _viewModelProviderMap[T]! as AutoDisposeChangeNotifierProvider<T>;
}

class BaseView<T extends ViewModelBase> extends ConsumerWidget {
  final T Function() viewModelBuilder;
  final Widget Function(BuildContext context, T viewModel, WidgetRef ref)
      builder;
  final void Function(T viewModel)? onModelReady;

  const BaseView({
    super.key,
    required this.viewModelBuilder,
    required this.builder,
    this.onModelReady,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = autoViewModelProvider<T>(viewModelBuilder);
    final viewModel = ref.watch(provider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      onModelReady?.call(viewModel);
    });

    return builder(context, viewModel, ref);
  }
}
