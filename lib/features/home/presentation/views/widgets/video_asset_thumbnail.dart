import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// First-frame thumbnail for a bundled video asset (used in grids).
class VideoAssetThumbnail extends StatefulWidget {
  const VideoAssetThumbnail({
    super.key,
    required this.assetPath,
    this.iconColor,
  });

  final String assetPath;
  final Color? iconColor;

  @override
  State<VideoAssetThumbnail> createState() => _VideoAssetThumbnailState();
}

class _VideoAssetThumbnailState extends State<VideoAssetThumbnail> {
  VideoPlayerController? _controller;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final c = VideoPlayerController.asset(widget.assetPath);
    try {
      await c.initialize();
      await c.pause();
      await c.seekTo(Duration.zero);
      if (!mounted) {
        c.dispose();
        return;
      }
      setState(() => _controller = c);
    } catch (_) {
      c.dispose();
      if (mounted) setState(() => _failed = true);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accent = widget.iconColor ?? const Color(0xFF083A30);

    if (_failed || _controller == null || !_controller!.value.isInitialized) {
      return ColoredBox(
        color: accent.withValues(alpha: 0.12),
        child: Center(
          child: Icon(
            Icons.videocam_rounded,
            size: 40,
            color: accent.withValues(alpha: 0.5),
          ),
        ),
      );
    }

    return FittedBox(
      fit: BoxFit.cover,
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: _controller!.value.size.width,
        height: _controller!.value.size.height,
        child: VideoPlayer(_controller!),
      ),
    );
  }
}
