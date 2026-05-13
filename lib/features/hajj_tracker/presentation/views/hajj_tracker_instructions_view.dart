import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holly_quran/core/di/service_locator.dart';
import 'package:holly_quran/core/shared_preferences/app_preferences.dart';
import 'package:holly_quran/features/hajj_tracker/presentation/cubit/hajj_tracker_cubit.dart';
import 'package:holly_quran/features/hajj_tracker/presentation/views/hajj_tracker_scroll_view.dart';

/// Instruction bullets before opening the checklist.
class HajjTrackerInstructionsView extends StatelessWidget {
  const HajjTrackerInstructionsView({super.key});

  static const Color _deep = Color(0xFF0F3D2E);
  static const Color _mid = Color(0xFF1B5E40);
  static const Color _light = Color(0xFFC8E6C9);

  static const List<String> _bullets = [
    'اقرأ المناسك قبل كل عمل، واستحضر نيتك واستعد له.',
    'ضع علامة إتمام بعد كل منسك لتتابع تقدّمك.',
    'تابع أعمالك يوماً بيوم حتى تكمل الحج بانتظام وطمأنينة.',
    'اغتنم وقتك بالصلاة والقرآن والذكر والدعاء.',
    'التزم بتوجيه العلماء المرافقين.',
    'اجعل البطاقة رفيقك لتساعدك على التركيز وعدم النسيان وسط الزحام.',
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [_deep, _mid, _light],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'تعليمات استخدام بطاقة متابعة الحاج',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView.separated(
                      itemCount: _bullets.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 14),
                      itemBuilder: (context, i) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                _bullets[i],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  height: 1.45,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const Divider(color: Colors.white54, height: 32),
                  const Text(
                    'هذه البطاقة من إعداد تكتل الماسي، لتكون عوناً للحاج في رحلته المباركة، ودليلاً عملياً يجمع بين الوضوح والروحانية.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) => HajjTrackerCubit(getIt<AppPreferences>()),
                            child: const HajjTrackerScrollView(),
                          ),
                        ),
                      );
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: _deep,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'فهمت — ابدأ المتابعة',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
