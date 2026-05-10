import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:holly_quran/core/extension/extensions.dart';

import '../../../../../core/resources/values_manager.dart';

/// Plays a local asset or remote URL for a duaa item whose [DuaaModel.type] is `"audio"`.
class DuaaAudioPlayer extends StatefulWidget {
  final String assetPath;
  final String assetName;

  const DuaaAudioPlayer({
    super.key,
    required this.assetPath,
    required this.assetName,
  });

  @override
  State<DuaaAudioPlayer> createState() => _DuaaAudioPlayerState();
}

class _DuaaAudioPlayerState extends State<DuaaAudioPlayer> {
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
          _errorMessage = 'فشل في تحميل الصوت: $e';
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
    } catch (e) {
      if (mounted) {
        setState(() => _errorMessage = 'تعذر التشغيل: $e');
      }
    }
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
          colors: [Color(0xFFF5F5F5), Color(0xFFFFFFFF)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: context.height * 0.28,
              child: Image.asset(
                'assets/images/mawasem_logo.png',
                fit: BoxFit.contain,
              ),
            ),
            Text(
              widget.assetName,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: AppSize.s20),
            if (_isLoading)
              const Expanded(
                child: Center(child: CircularProgressIndicator()),
              )
            else if (_errorMessage != null)
              Expanded(
                child: Center(
                  child: Text(
                    _errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              )
            else
              Expanded(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.p20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              iconSize: AppSize.s60,
                              onPressed: _togglePlay,
                              icon: Icon(
                                _playerState == PlayerState.playing
                                    ? Icons.pause_circle_filled
                                    : Icons.play_circle_filled,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ],
                        ),
                        Slider(
                          min: 0,
                          max: _duration.inMilliseconds > 0
                              ? _duration.inMilliseconds.toDouble()
                              : 1,
                          value: _position.inMilliseconds
                              .clamp(0, _duration.inMilliseconds)
                              .toDouble(),
                          onChanged: _duration.inMilliseconds > 0
                              ? (v) {
                                  _player.seek(
                                    Duration(milliseconds: v.round()),
                                  );
                                }
                              : null,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(_formatDuration(_position)),
                            Text(_formatDuration(_duration)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    if (d.inHours > 0) {
      final h = d.inHours.toString().padLeft(2, '0');
      return '$h:$m:$s';
    }
    return '$m:$s';
  }
}
