import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

/// Full-screen video player for bundled MP4 assets.
class DuaaVideoPlayer extends StatefulWidget {
  const DuaaVideoPlayer({
    super.key,
    required this.assetPath,
    required this.videoTitle,
  });

  final String assetPath;
  final String videoTitle;

  @override
  State<DuaaVideoPlayer> createState() => _DuaaVideoPlayerState();
}

class _DuaaVideoPlayerState extends State<DuaaVideoPlayer> {
  static const Color _darkGreen = Color(0xFF083A30);
  static const Color _gold = Color(0xFFC9A961);

  late VideoPlayerController _videoController;
  ChewieController? _chewieController;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      _videoController = VideoPlayerController.asset(widget.assetPath);
      await _videoController.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoController,
        autoPlay: false,
        looping: false,
        allowFullScreen: true,
        allowMuting: true,
        showControlsOnInitialize: true,
        aspectRatio: _videoController.value.aspectRatio,
        materialProgressColors: ChewieProgressColors(
          playedColor: _gold,
          handleColor: _gold,
          backgroundColor: Colors.white24,
          bufferedColor: Colors.white38,
        ),
        placeholder: const ColoredBox(color: Colors.black),
        errorBuilder: (context, message) => Center(
          child: Text(
            message,
            textDirection: TextDirection.rtl,
            style: const TextStyle(color: Colors.white70, fontFamily: 'Cairo'),
          ),
        ),
      );

      if (mounted) setState(() => _isLoading = false);
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'فشل في تحميل الفيديو';
        });
      }
    }
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    _chewieController?.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ColoredBox(
        color: Colors.black,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Center(
                  child: _isLoading
                      ? const CircularProgressIndicator(color: _gold)
                      : _errorMessage != null
                          ? Padding(
                              padding: const EdgeInsets.all(AppPadding.p20),
                              child: Text(
                                _errorMessage!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            )
                          : Chewie(controller: _chewieController!),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(
                  AppPadding.p16,
                  AppPadding.p12,
                  AppPadding.p16,
                  AppPadding.p16,
                ),
                decoration: BoxDecoration(
                  color: _darkGreen,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Text(
                  widget.videoTitle,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Cairo',
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
