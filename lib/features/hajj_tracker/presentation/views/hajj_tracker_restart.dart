import 'package:flutter/material.dart';
import 'package:holly_quran/core/di/service_locator.dart';
import 'package:holly_quran/core/shared_preferences/app_preferences.dart';
import 'package:holly_quran/features/hajj_tracker/presentation/views/hajj_tracker_welcome_view.dart';

/// Shared confirmation + navigation: clears prefs and returns to name entry.
Future<void> confirmRestartHajjToWelcome(BuildContext context) async {
  final ok = await showDialog<bool>(
    context: context,
    builder: (ctx) => Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        title: const Text(
          'تأكيد',
          style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w800),
        ),
        content: const Text(
          'سيتم مسح اسم الحاج وجميع علامات التقدّم. هل تريد المتابعة؟',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w600,
            height: 1.45,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text(
              'إلغاء',
              style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w700),
            ),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF0F5847),
            ),
            child: const Text(
              'تأكيد',
              style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    ),
  );
  if (ok != true || !context.mounted) return;
  await getIt<AppPreferences>().clearHajjTrackerFully();
  if (!context.mounted) return;
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (_) => const HajjTrackerWelcomeView()),
    (route) => route.isFirst,
  );
}
