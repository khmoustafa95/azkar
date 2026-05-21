import 'package:flutter/material.dart';

/// PageView carousel with optional autoplay (replaces carousel_slider).
class AppPageCarousel extends StatefulWidget {
  const AppPageCarousel({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.height,
    this.viewportFraction = 1.0,
    this.initialPage = 0,
    this.autoPlay = false,
    this.autoPlayInterval = const Duration(seconds: 4),
    this.onPageChanged,
    this.alignItemsTop = false,
  });

  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  /// When null, fills parent (use inside [Expanded]).
  final double? height;
  final double viewportFraction;
  final int initialPage;
  final bool autoPlay;
  final Duration autoPlayInterval;
  final ValueChanged<int>? onPageChanged;

  /// When true, each page is top-aligned (avoids empty gap under short cards).
  final bool alignItemsTop;

  @override
  State<AppPageCarousel> createState() => AppPageCarouselState();
}

class AppPageCarouselState extends State<AppPageCarousel> {
  late final PageController _controller;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _index = widget.initialPage.clamp(0, widget.itemCount > 0 ? widget.itemCount - 1 : 0);
    _controller = PageController(
      initialPage: _index,
      viewportFraction: widget.viewportFraction,
    );
    if (widget.autoPlay && widget.itemCount > 1) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _scheduleAutoPlay());
    }
  }

  @override
  void didUpdateWidget(covariant AppPageCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.autoPlay && !oldWidget.autoPlay && widget.itemCount > 1) {
      _scheduleAutoPlay();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void jumpToPage(int page) {
    if (page < 0 || page >= widget.itemCount) return;
    _controller.jumpToPage(page);
    if (_index != page) {
      setState(() => _index = page);
    }
  }

  Future<void> _scheduleAutoPlay() async {
    if (!mounted || !widget.autoPlay || widget.itemCount <= 1) return;
    await Future<void>.delayed(widget.autoPlayInterval);
    if (!mounted || !widget.autoPlay) return;
    if (!_controller.hasClients) {
      _scheduleAutoPlay();
      return;
    }
    final next = _index + 1;
    if (next < widget.itemCount) {
      await _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOutCubic,
      );
    }
    _scheduleAutoPlay();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itemCount == 0) {
      return widget.height != null
          ? SizedBox(height: widget.height)
          : const SizedBox.shrink();
    }

    final pageView = PageView.builder(
        controller: _controller,
        itemCount: widget.itemCount,
        onPageChanged: (index) {
          setState(() => _index = index);
          widget.onPageChanged?.call(index);
        },
        itemBuilder: (context, index) {
          var child = widget.itemBuilder(context, index);
          if (widget.alignItemsTop) {
            child = Align(alignment: Alignment.topCenter, child: child);
          }
          if (widget.viewportFraction >= 0.99) {
            return child;
          }
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              double scale = 1.0;
              if (_controller.position.haveDimensions) {
                final page = _controller.page ?? _index.toDouble();
                scale = (1 - (page - index).abs() * 0.15).clamp(0.88, 1.0);
              }
              return Transform.scale(scale: scale, child: child);
            },
            child: child,
          );
        },
    );

    if (widget.height == null) {
      return pageView;
    }

    return SizedBox(
      height: widget.height,
      child: pageView,
    );
  }
}
