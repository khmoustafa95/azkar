import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:video_player/video_player.dart';

/// A self-contained, brand-styled player for the "who we are" coalition
/// video shown at the top of the Contact Us page.
///
/// - Lazily initialises a [VideoPlayerController] from an asset.
/// - Wraps it in a [ChewieController] for native-feeling controls.
/// - Honours its initial natural aspect ratio (falls back to 16:9 while
///   loading or on error).
/// - Owns its lifecycle and disposes both controllers on tear-down.
class WhoWeAreVideo extends StatefulWidget {
  const WhoWeAreVideo({
    super.key,
    required this.assetPath,
    this.title,
    this.subtitle,
    this.autoPlay = false,
    this.borderRadius = AppSize.s20,
  });

  final String assetPath;

  /// Optional Arabic title displayed in a pill above the video.
  final String? title;

  /// Optional subtitle / one-line description shown under the title.
  final String? subtitle;

  /// Whether to start playback automatically when the widget mounts.
  final bool autoPlay;

  final double borderRadius;

  @override
  State<WhoWeAreVideo> createState() => _WhoWeAreVideoState();
}

class _WhoWeAreVideoState extends State<WhoWeAreVideo> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initialise();
  }

  Future<void> _initialise() async {
    try {
      final controller = VideoPlayerController.asset(widget.assetPath);
      _videoController = controller;
      await controller.initialize();

      _chewieController = ChewieController(
        videoPlayerController: controller,
        autoPlay: widget.autoPlay,
        looping: false,
        allowFullScreen: true,
        allowMuting: true,
        showControlsOnInitialize: true,
        aspectRatio: controller.value.aspectRatio == 0
            ? 16 / 9
            : controller.value.aspectRatio,
        materialProgressColors: ChewieProgressColors(
          playedColor: AppColors.primary,
          handleColor: AppColors.splash,
          backgroundColor: Colors.white24,
          bufferedColor: Colors.white54,
        ),
        placeholder: const ColoredBox(color: Colors.black),
        errorBuilder: (context, errorMessage) => _ErrorState(message: errorMessage),
      );

      if (!mounted) return;
      setState(() => _isLoading = false);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = 'تعذر تحميل الفيديو';
      });
    }
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final aspect = (_videoController?.value.isInitialized ?? false)
        ? _videoController!.value.aspectRatio
        : 16 / 9;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.title != null || widget.subtitle != null) ...[
          _VideoHeader(
            title: widget.title,
            subtitle: widget.subtitle,
          ),
          const SizedBox(height: AppSize.s12),
        ],
        AspectRatio(
          aspectRatio: aspect,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 18,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              child: _buildBody(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    if (_errorMessage != null) {
      return _ErrorState(message: _errorMessage!);
    }
    if (_isLoading || _chewieController == null) {
      return const _LoadingState();
    }
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(color: Colors.black),
        Chewie(controller: _chewieController!),
        // Thin gold inner border for the ID-pass / branded feel.
        IgnorePointer(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              border: Border.all(color: const Color(0x80C9A961), width: 1.2),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Pieces
// ─────────────────────────────────────────────────────────────────────────────

class _VideoHeader extends StatelessWidget {
  const _VideoHeader({this.title, this.subtitle});

  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 28,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: AppSize.s8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null)
                Text(
                  title!,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primary,
                    height: 1.1,
                  ),
                ),
              if (subtitle != null) ...[
                const SizedBox(height: 2),
                Text(
                  subtitle!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                    height: 1.3,
                  ),
                ),
              ],
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p8,
            vertical: AppPadding.p4,
          ),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.35),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.play_circle_fill_rounded,
                  color: AppColors.primary, size: 16),
              const SizedBox(width: 4),
              Text(
                'فيديو',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator(
              strokeWidth: 2.6,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: AppSize.s12),
          const Text(
            'جاري تحميل الفيديو…',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.white70, size: 36),
          const SizedBox(height: AppSize.s8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
