import 'package:flutter/material.dart';

class BaseContainer extends StatefulWidget {
  final Widget child;
  final EdgeInsets padding;
  final bool isScrollable;
  final bool showScrollbar;

  const BaseContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
    this.isScrollable = true,
    this.showScrollbar = false,
  });

  @override
  State<BaseContainer> createState() => _BaseContainerState();
}

class _BaseContainerState extends State<BaseContainer> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: widget.padding,
      child: widget.child,
    );

    Widget scrollableContent = SingleChildScrollView(
      controller: _scrollController,
      child: content,
    );

    if (widget.isScrollable && widget.showScrollbar) {
      scrollableContent = Scrollbar(
        controller: _scrollController,
        thumbVisibility: false,
        child: scrollableContent,
      );
    }

    return SafeArea(
      child: widget.isScrollable ? scrollableContent : content,
    );
  }
}
