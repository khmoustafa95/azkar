import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:holly_quran/core/helper_functions/functions.dart';
import 'package:holly_quran/core/widgets/slideshow/slide_item.dart';
import 'package:holly_quran/core/widgets/slideshow/widgets/slideshow_progress_bars.dart';
import 'package:holly_quran/core/widgets/slideshow/widgets/slideshow_speed_chip.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

/// Stories-style fullscreen slideshow.
///
/// Reusable across any [SlideItem] list. Features:
///   • Auto-advance with adjustable duration (cycled via [SlideshowSpeedChip])
///   • Linear progress bars at the top, one per slide
///   • Tap left third → previous, right third → next, middle → pause/resume
///   • Long-press anywhere → pause while held
///   • Manual horizontal swipe → auto-pause (user is in control)
///   • Swipe down → close (returns the final page index)
///   • Force portrait + immersive system UI + screen wake-lock while active
///
/// Pop result is the index of the slide the user was on when closing, so a
/// parent landing view can sync its position.
class ImmersiveSlideShow extends StatefulWidget {
  const ImmersiveSlideShow({
    super.key,
    required this.slides,
    this.initialIndex = 0,
    this.durations = const [
      Duration(seconds: 8),
      Duration(seconds: 12),
      Duration(seconds: 15),
    ],
    this.initialDurationIndex = 0,
    this.backgroundColor = const Color(0xFF000000),
  });

  final List<SlideItem> slides;
  final int initialIndex;
  final List<Duration> durations;
  final int initialDurationIndex;
  final Color backgroundColor;

  /// Helper to push the immersive view as a fullscreen dialog. Returns the
  /// index of the last visible slide when the user closes.
  static Future<int?> push(
    BuildContext context, {
    required List<SlideItem> slides,
    int initialIndex = 0,
    int initialDurationIndex = 0,
  }) {
    return Navigator.of(context).push<int>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => ImmersiveSlideShow(
          slides: slides,
          initialIndex: initialIndex,
          initialDurationIndex: initialDurationIndex,
        ),
      ),
    );
  }

  @override
  State<ImmersiveSlideShow> createState() => _ImmersiveSlideShowState();
}

class _ImmersiveSlideShowState extends State<ImmersiveSlideShow>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _progress;

  int _currentIndex = 0;
  int _durationIndex = 0;
  bool _isPaused = false;
  bool _programmaticChange = false;
  bool _showPauseHint = false;

  Duration get _currentDuration => widget.durations[_durationIndex];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex.clamp(0, widget.slides.length - 1);
    _durationIndex =
        widget.initialDurationIndex.clamp(0, widget.durations.length - 1);
    _pageController = PageController(initialPage: _currentIndex);
    _progress = AnimationController(vsync: this, duration: _currentDuration)
      ..addStatusListener(_onProgressStatus);
    _enterImmersive();
    _progress.forward();
  }

  void _enterImmersive() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    WakelockPlus.enable();
  }

  void _restoreSystemUi() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    WakelockPlus.disable();
  }

  void _onProgressStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed && !_isPaused) {
      _advance();
    }
  }

  void _restartProgress() {
    _progress
      ..stop()
      ..reset()
      ..duration = _currentDuration;
    if (!_isPaused) _progress.forward();
  }

  void _advance() {
    if (_currentIndex >= widget.slides.length - 1) {
      _close();
      return;
    }
    _goTo(_currentIndex + 1);
  }

  void _goBackOne() {
    if (_currentIndex <= 0) return;
    _goTo(_currentIndex - 1);
  }

  void _goTo(int index) {
    if (index == _currentIndex) return;
    _programmaticChange = true;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeInOutCubic,
    );
  }

  void _onPageChanged(int index) {
    final wasProgrammatic = _programmaticChange;
    _programmaticChange = false;
    setState(() => _currentIndex = index);
    if (wasProgrammatic) {
      _restartProgress();
    } else {
      _userPause();
    }
  }

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
      _showPauseHint = true;
    });
    if (_isPaused) {
      _progress.stop();
    } else {
      _progress.forward();
    }
    Future.delayed(const Duration(milliseconds: 900), () {
      if (mounted) setState(() => _showPauseHint = false);
    });
  }

  void _userPause() {
    if (_isPaused) return;
    setState(() => _isPaused = true);
    _progress.stop();
  }

  void _onLongPressStart(LongPressStartDetails _) {
    if (_isPaused) return;
    _progress.stop();
  }

  void _onLongPressEnd(LongPressEndDetails _) {
    if (_isPaused) return;
    _progress.forward();
  }

  void _onTapUp(TapUpDetails details) {
    final width = MediaQuery.of(context).size.width;
    final x = details.localPosition.dx;
    if (x < width / 3) {
      _goBackOne();
    } else if (x > width * 2 / 3) {
      _advance();
    } else {
      _togglePause();
    }
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    if ((details.primaryVelocity ?? 0) > 600) _close();
  }

  void _cycleDuration() {
    setState(() {
      _durationIndex = (_durationIndex + 1) % widget.durations.length;
    });
    _restartProgress();
  }

  void _close() {
    Navigator.of(context).pop(_currentIndex);
  }

  @override
  void dispose() {
    _progress.dispose();
    _pageController.dispose();
    _restoreSystemUi();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return PopScope(
      onPopInvokedWithResult: (_, __) => _restoreSystemUi(),
      child: Scaffold(
        backgroundColor: widget.backgroundColor,
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTapUp: _onTapUp,
          onLongPressStart: _onLongPressStart,
          onLongPressEnd: _onLongPressEnd,
          onVerticalDragEnd: _onVerticalDragEnd,
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: widget.slides.length,
                itemBuilder: (_, i) => _SlideImage(slide: widget.slides[i]),
              ),
              Positioned(
                top: mq.padding.top + 12,
                left: 12,
                right: 12,
                child: _TopBar(
                  count: widget.slides.length,
                  currentIndex: _currentIndex,
                  progress: _progress,
                  isPaused: _isPaused,
                  durations: widget.durations,
                  durationIndex: _durationIndex,
                  onTogglePause: _togglePause,
                  onCycleDuration: _cycleDuration,
                  onClose: _close,
                ),
              ),
              Positioned(
                bottom: mq.padding.bottom + 18,
                left: 0,
                right: 0,
                child: _CounterPill(
                  current: _currentIndex + 1,
                  total: widget.slides.length,
                ),
              ),
              if (_showPauseHint)
                _PauseHintOverlay(isPaused: _isPaused),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Slide image with graceful fallback
// ─────────────────────────────────────────────────────────────────────────────

class _SlideImage extends StatelessWidget {
  const _SlideImage({required this.slide});
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
                Icons.broken_image_outlined,
                color: Colors.white60,
                size: 64,
              ),
              const SizedBox(height: 14),
              Text(
                slide.title ?? 'الصورة غير متوفرة',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Cairo',
                ),
              ),
              const SizedBox(height: 8),
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

// ─────────────────────────────────────────────────────────────────────────────
// Top bar
// ─────────────────────────────────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.count,
    required this.currentIndex,
    required this.progress,
    required this.isPaused,
    required this.durations,
    required this.durationIndex,
    required this.onTogglePause,
    required this.onCycleDuration,
    required this.onClose,
  });

  final int count;
  final int currentIndex;
  final Animation<double> progress;
  final bool isPaused;
  final List<Duration> durations;
  final int durationIndex;
  final VoidCallback onTogglePause;
  final VoidCallback onCycleDuration;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SlideshowProgressBars(
          count: count,
          currentIndex: currentIndex,
          progress: progress,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _CircleIconButton(
              icon: Icons.close_rounded,
              onTap: onClose,
            ),
            const SizedBox(width: 8),
            _CircleIconButton(
              icon: isPaused
                  ? Icons.play_arrow_rounded
                  : Icons.pause_rounded,
              onTap: onTogglePause,
            ),
            const Spacer(),
            SlideshowSpeedChip(
              durations: durations,
              currentIndex: durationIndex,
              onChanged: (_) => onCycleDuration(),
            ),
          ],
        ),
      ],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0x33FFFFFF),
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0x55FFFFFF)),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Bottom counter pill (٣ من ١٦)
// ─────────────────────────────────────────────────────────────────────────────

class _CounterPill extends StatelessWidget {
  const _CounterPill({required this.current, required this.total});
  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0x66000000),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0x33FFFFFF)),
        ),
        child: Text(
          '${arNumber(current.toString())} من ${arNumber(total.toString())}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12.5,
            fontWeight: FontWeight.w800,
            fontFamily: 'Cairo',
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Center pause/play hint (briefly visible after toggle)
// ─────────────────────────────────────────────────────────────────────────────

class _PauseHintOverlay extends StatelessWidget {
  const _PauseHintOverlay({required this.isPaused});
  final bool isPaused;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Center(
        child: AnimatedOpacity(
          opacity: 1,
          duration: const Duration(milliseconds: 200),
          child: Container(
            width: 84,
            height: 84,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0x88000000),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0x44FFFFFF)),
            ),
            child: Icon(
              isPaused ? Icons.pause_rounded : Icons.play_arrow_rounded,
              color: Colors.white,
              size: 48,
            ),
          ),
        ),
      ),
    );
  }
}
