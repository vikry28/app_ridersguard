import 'package:app_riderguard/core/utils/assets_helper.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RefreshableWidget extends StatefulWidget {
  final Future<void> Function() onRefresh;
  final Future<void> Function()? onLoadMore;
  final bool isLoadingMore;
  final Widget Function(ScrollController controller) builder;
  final bool hasMoreData;
  final EdgeInsetsGeometry? padding;

  const RefreshableWidget({
    super.key,
    required this.onRefresh,
    required this.builder,
    this.onLoadMore,
    this.isLoadingMore = false,
    this.hasMoreData = false,
    this.padding,
  });

  @override
  State<RefreshableWidget> createState() => _RefreshableWidgetState();
}

class _RefreshableWidgetState extends State<RefreshableWidget> {
  late final ScrollController _scrollController;
  bool _isRefreshing = false;
  bool _showLottie = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (widget.onLoadMore == null ||
        widget.isLoadingMore ||
        !widget.hasMoreData) {
      return;
    }

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      widget.onLoadMore!();
    }
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _isRefreshing = true;
      _showLottie = true;
    });
    await widget.onRefresh();
    if (mounted) {
      setState(() {
        _isRefreshing = false;
        _showLottie = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is OverscrollNotification &&
            !_isRefreshing &&
            notification.overscroll < 0) {
          // User mulai menarik ke bawah
          setState(() {
            _showLottie = true;
          });
        }
        return false;
      },
      child: Stack(
        children: [
          RefreshIndicator(
            onRefresh: _handleRefresh,
            edgeOffset: 60,
            displacement: 60,
            child: Padding(
              padding: widget.padding ?? EdgeInsets.zero,
              child: Column(
                children: [
                  Expanded(child: widget.builder(_scrollController)),
                  if (widget.isLoadingMore)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
          ),
          if (_showLottie)
            Positioned.fill(
              child: IgnorePointer(
                child: Center(
                  child: Lottie.asset(
                    AssetsHelper.refresh,
                    width: 100,
                    height: 100,
                    repeat: true,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
