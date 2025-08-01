import 'package:flutter/material.dart';

class BaseContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final bool isScrollable;

  const BaseContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
    this.isScrollable = true,
  });

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: padding,
      child: child,
    );

    return SafeArea(
      child: isScrollable ? SingleChildScrollView(child: content) : content,
    );
  }
}
