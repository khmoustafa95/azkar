import 'package:flutter/material.dart';
import 'package:holly_quran/features/hajj_tracker/presentation/views/hajj_tracker_restart.dart';

/// Shown after completing the last ritual (طواف الوداع) — congratulations + restart.
class HajjTrackerCongratsView extends StatelessWidget {
  const HajjTrackerCongratsView({super.key});

  static const String _acceptanceDua =
      'اللهم تقبل مني حجِّي وعمرتي، واغفر لي ذنبي كله، واجعلهما خالصين لوجهك الكريم، '
      'ولا تجعل لي فيهما هباءً منثوراً. اللهم ارزقني قبولاً يرتاح به قلبي، '
      'وثبِّتني على دينك، وبارك لي فيما بقي من عمري.';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFF083A30),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0F5847),
          foregroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'تهانينا',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w800,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_forward_ios_rounded),
            onPressed: () => Navigator.of(context).pop(),
            tooltip: 'رجوع',
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 12),
                Icon(
                  Icons.celebration_rounded,
                  size: 72,
                  color: const Color(0xFFC9A961).withValues(alpha: 0.95),
                ),
                const SizedBox(height: 20),
                const Text(
                  'بارك الله فيك',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w900,
                    fontSize: 26,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'أتممتَ متابعة مناسك الحج — نسأل الله أن يتقبل منك وأن يغفر لك ويرحمك.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.92),
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    height: 1.55,
                  ),
                ),
                const SizedBox(height: 28),
                const Text(
                  'دعاء القبول',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFC9A961),
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: Text(
                    _acceptanceDua,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.96),
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      height: 1.7,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                FilledButton.icon(
                  onPressed: () => confirmRestartHajjToWelcome(context),
                  icon: const Icon(Icons.person_outline_rounded),
                  label: const Text(
                    'ابدأ من جديد',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFFC9A961),
                    foregroundColor: const Color(0xFF083A30),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
