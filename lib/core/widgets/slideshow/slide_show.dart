import 'dart:async';

import 'package:flutter/material.dart';
import 'package:holly_quran/core/helper_functions/functions.dart';
import 'package:holly_quran/features/common_widgets/app_bar.dart';
import 'package:holly_quran/core/widgets/slideshow/immersive_slide_show.dart';
import 'package:holly_quran/core/widgets/slideshow/slide_item.dart';
import 'package:holly_quran/core/widgets/slideshow/widgets/slideshow_dots_indicator.dart';
import 'package:holly_quran/core/widgets/slideshow/widgets/slideshow_speed_chip.dart';

/// Generic auto-playing slideshow landing screen.
class SlideShow extends StatefulWidget {
  const SlideShow({
    super.key,
    required this.slides,
    this.title,
    this.initialIndex = 0,
    this.durations = const [
      Duration(seconds: 8),
      Duration(seconds: 12),
      Duration(seconds: 15),
    ],
    this.initialDurationIndex = 0,
    this.primaryColor = const Color(0xFF0F5847),
    this.darkColor = const Color(0xFF083A30),
    this.accentColor = const Color(0xFFC9A961),
    this.backdropColor = const Color(0xFF111B17),
  });

  final List<SlideItem> slides;
  final String? title;
  final int initialIndex;
  final List<Duration> durations;
  final int initialDurationIndex;
  final Color primaryColor;
  final Color darkColor;
  final Color accentColor;
  final Color backdropColor;

  @override
  State<SlideShow> createState() => _SlideShowState();
}

class _SlideShowState extends State<SlideShow> {
  late final PageController _pageController;
  late int _currentIndex;
  late int _durationIndex;
  bool _isPaused = false;
  Timer? _autoPlayTimer;

  Duration get _currentDuration => widget.durations[_durationIndex];

  @override
  void initState() {
    super.initState();
    _currentIndex =
        widget.initialIndex.clamp(0, widget.slides.length - 1).toInt();
    _durationIndex = widget.initialDurationIndex
        .clamp(0, widget.durations.length - 1)
        .toInt();
    _pageController = PageController(initialPage: _currentIndex);
    _scheduleAutoPlay();
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _scheduleAutoPlay() {
    _autoPlayTimer?.cancel();
    if (_isPaused || widget.slides.length <= 1) return;
    _autoPlayTimer = Timer(_currentDuration, () {
      if (!mounted || _isPaused) return;
      final next = _currentIndex + 1;
      if (next < widget.slides.length && _pageController.hasClients) {
        _pageController
            .animateToPage(
              next,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOutCubic,
            )
            .then((_) => _scheduleAutoPlay());
      }
    });
  }

  void _onPageChanged(int index) {
    final manual = index != _currentIndex;
    setState(() {
      _currentIndex = index;
      if (manual && !_isPaused) {
        _isPaused = true;
      }
    });
    _scheduleAutoPlay();
  }

  void _togglePause() {
    setState(() => _isPaused = !_isPaused);
    _scheduleAutoPlay();
  }

  void _cycleDuration() {
    setState(() {
      _durationIndex = (_durationIndex + 1) % widget.durations.length;
    });
    _scheduleAutoPlay();
  }

  Future<void> _openImmersive() async {
    final result = await ImmersiveSlideShow.push(
      context,
      slides: widget.slides,
      initialIndex: _currentIndex,
      initialDurationIndex: _durationIndex,
    );
    if (!mounted) return;
    if (result != null && result != _currentIndex) {
      setState(() => _currentIndex = result);
      _pageController.jumpToPage(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: widget.backdropColor,
        appBar: AppNavigationBar(
          title: widget.title ?? '',
          backgroundColor: widget.darkColor,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: SlideshowSpeedChip(
                durations: widget.durations,
                currentIndex: _durationIndex,
                onChanged: (_) => _cycleDuration(),
              ),
            ),
            IconButton(
              tooltip: _isPaused ? 'تشغيل' : 'إيقاف مؤقت',
              onPressed: _togglePause,
              icon: Icon(
                _isPaused ? Icons.play_arrow_rounded : Icons.pause_rounded,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: SafeArea(
          top: false,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: widget.backdropColor,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: widget.slides.length,
                    onPageChanged: _onPageChanged,
                    itemBuilder: (context, index) {
                      return _SlideTile(slide: widget.slides[index]);
                    },
                  ),
                ),
              ),
              _BottomBar(
                count: widget.slides.length,
                currentIndex: _currentIndex,
                primary: widget.primaryColor,
                dark: widget.darkColor,
              ),
              SizedBox(height: mq.padding.bottom),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _openImmersive,
          backgroundColor: widget.primaryColor,
          foregroundColor: Colors.white,
          icon: const Icon(Icons.slideshow_rounded),
          label: const Text(
            'عرض كامل',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}

class _SlideTile extends StatelessWidget {
  const _SlideTile({required this.slide});
  final SlideItem slide;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        slide.asset,
        fit: BoxFit.contain,
        gaplessPlayback: true,
        semanticLabel: slide.semanticsLabel ?? slide.title,
        errorBuilder: (context, error, stackTrace) => Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.image_not_supported_outlined,
                color: Colors.white60,
                size: 56,
              ),
              const SizedBox(height: 12),
              Text(
                slide.title ?? 'الصورة غير متوفرة',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Cairo',
                ),
              ),
              const SizedBox(height: 6),
              Text(
                slide.asset,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white38,
                  fontSize: 11,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.count,
    required this.currentIndex,
    required this.primary,
    required this.dark,
  });

  final int count;
  final int currentIndex;
  final Color primary;
  final Color dark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 14,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: SlideshowDotsIndicator(
              count: count,
              currentIndex: currentIndex,
              activeColor: primary,
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: dark.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${arNumber((currentIndex + 1).toString())} من ${arNumber(count.toString())}',
              style: TextStyle(
                color: dark,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                fontFamily: 'Cairo',
                letterSpacing: 0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
