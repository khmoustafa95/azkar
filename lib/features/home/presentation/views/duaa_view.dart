import 'package:flutter/material.dart';
import 'package:holly_quran/core/widgets/slideshow/slide_show.dart';
import 'package:holly_quran/features/common_widgets/app_bar.dart';
import 'package:holly_quran/features/home/data/duaa_content_data.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/duaa_player.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/duaa_video_player.dart';

import '../../data/models/duaa/duaa_model.dart';

class DuaaView extends StatelessWidget {
  const DuaaView({super.key, required this.duaa, required this.id});

  final DuaaModel duaa;
  final String id;

  static const Color _darkGreen = Color(0xFF083A30);

  @override
  Widget build(BuildContext context) {
    final isVideo = duaa.type == 'video';

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: isVideo ? Colors.black : _darkGreen,
        appBar: isVideo
            ? null
            : AppNavigationBar(
                title: duaa.name,
                backgroundColor: _darkGreen,
              ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    switch (duaa.type) {
      case 'audio':
        return DuaaAudioPlayer(
          assetPath: duaa.url,
          assetName: duaa.name,
        );
      case 'slideshow':
        return SlideShow(
          slides: textPrayerSlides,
          title: duaa.name,
          primaryColor: const Color(0xFF2D6A4F),
        );
      case 'video':
      default:
        return DuaaVideoPlayer(
          videoTitle: duaa.name,
          assetPath: duaa.url,
        );
    }
  }
}
