import 'dart:async';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/values_manager.dart';

/// Full-screen audio player for a duaa track.
class DuaaAudioPlayer extends StatefulWidget {
  const DuaaAudioPlayer({
    super.key,
    required this.assetPath,
    required this.assetName,
  });

  final String assetPath;
  final String assetName;

  @override
  State<DuaaAudioPlayer> createState() => _DuaaAudioPlayerState();
}

class _DuaaAudioPlayerState extends State<DuaaAudioPlayer> {
  static const Color _darkGreen = Color(0xFF083A30);
  static const Color _primary = Color(0xFF2D6A4F);
  static const Color _gold = Color(0xFFC9A961);

  late final AudioPlayer _player;
  final List<StreamSubscription<dynamic>> _subscriptions = [];

  PlayerState _playerState = PlayerState.stopped;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _subscriptions.addAll([
      _player.onPlayerStateChanged.listen((s) {
        if (mounted) setState(() => _playerState = s);
      }),
      _player.onDurationChanged.listen((d) {
        if (mounted) setState(() => _duration = d);
      }),
      _player.onPositionChanged.listen((p) {
        if (mounted) setState(() => _position = p);
      }),
      _player.onPlayerComplete.listen((_) {
        if (mounted) {
          setState(() {
            _playerState = PlayerState.completed;
            _position = Duration.zero;
          });
        }
      }),
    ]);
    _prepareSource();
  }

  Source _sourceFromPath(String path) {
    final trimmed = path.trim();
    if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
      return UrlSource(trimmed);
    }
    var assetKey = trimmed;
    if (assetKey.startsWith('assets/')) {
      assetKey = assetKey.substring('assets/'.length);
    }
    return AssetSource(assetKey);
  }

  Future<void> _prepareSource() async {
    try {
      await _player.setSource(_sourceFromPath(widget.assetPath));
      if (mounted) setState(() => _isLoading = false);
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'فشل في تحميل الصوت';
        });
      }
    }
  }

  Future<void> _togglePlay() async {
    if (_errorMessage != null || _isLoading) return;
    try {
      if (_playerState == PlayerState.playing) {
        await _player.pause();
      } else if (_playerState == PlayerState.paused) {
        await _player.resume();
      } else {
        await _player.play(_sourceFromPath(widget.assetPath));
      }
    } catch (_) {
      if (mounted) setState(() => _errorMessage = 'تعذر التشغيل');
    }
  }

  Future<void> _seekRelative(int seconds) async {
    final target = _position + Duration(seconds: seconds);
    final clamped = Duration(
      milliseconds: target.inMilliseconds.clamp(0, _duration.inMilliseconds),
    );
    await _player.seek(clamped);
  }

  @override
  void dispose() {
    for (final s in _subscriptions) {
      s.cancel();
    }
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [_darkGreen, Color(0xFF0F5847), Color(0xFF145A42)],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: Column(
            children: [
              const Spacer(flex: 2),
              _Artwork(),
              const SizedBox(height: AppSize.s28),
              Text(
                widget.assetName,
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Cairo',
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  height: 1.3,
                ),
              ),
              const Spacer(flex: 3),
              if (_isLoading)
                const CircularProgressIndicator(color: _gold)
              else if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.white70, fontFamily: 'Cairo'),
                )
              else ...[
                ProgressBar(
                  progress: _position,
                  total: _duration.inMilliseconds > 0
                      ? _duration
                      : const Duration(seconds: 1),
                  onSeek: (d) => _player.seek(d),
                  barHeight: 5,
                  baseBarColor: Colors.white24,
                  progressBarColor: _gold,
                  bufferedBarColor: Colors.white12,
                  thumbColor: _gold,
                  thumbRadius: 7,
                  timeLabelTextStyle: const TextStyle(
                    color: Colors.white70,
                    fontFamily: 'Cairo',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSize.s20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => _seekRelative(-10),
                      icon: const Icon(Icons.replay_10_rounded),
                      color: Colors.white70,
                      iconSize: 32,
                    ),
                    const SizedBox(width: AppSize.s12),
                    Material(
                      color: _gold,
                      shape: const CircleBorder(),
                      elevation: 8,
                      shadowColor: _gold.withValues(alpha: 0.5),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: _togglePlay,
                        child: SizedBox(
                          width: AppSize.s70,
                          height: AppSize.s70,
                          child: Icon(
                            _playerState == PlayerState.playing
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,
                            color: _darkGreen,
                            size: 44,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSize.s12),
                    IconButton(
                      onPressed: () => _seekRelative(10),
                      icon: const Icon(Icons.forward_10_rounded),
                      color: Colors.white70,
                      iconSize: 32,
                    ),
                  ],
                ),
              ],
              const SizedBox(height: AppSize.s32),
            ],
          ),
        ),
      ),
    );
  }
}

class _Artwork extends StatelessWidget {
  static const Color _gold = Color(0xFFC9A961);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 220,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: _gold.withValues(alpha: 0.25),
            blurRadius: 32,
            spreadRadius: 4,
          ),
        ],
        border: Border.all(
          color: _gold.withValues(alpha: 0.45),
          width: 3,
        ),
      ),
      child: ClipOval(
        child: Container(
          color: Colors.white.withValues(alpha: 0.08),
          padding: const EdgeInsets.all(AppPadding.p28),
          child: Image.asset(
            ImageAssets.dua,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
