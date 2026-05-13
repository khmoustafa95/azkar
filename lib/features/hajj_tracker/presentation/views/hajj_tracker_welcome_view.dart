import 'package:flutter/material.dart';
import 'package:holly_quran/core/di/service_locator.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/shared_preferences/app_preferences.dart';
import 'package:holly_quran/features/hajj_tracker/presentation/views/hajj_tracker_instructions_view.dart';

/// Cover screen: name entry + start (matches «بطاقة متابعة أعمال الحج» design).
class HajjTrackerWelcomeView extends StatefulWidget {
  const HajjTrackerWelcomeView({super.key});

  @override
  State<HajjTrackerWelcomeView> createState() => _HajjTrackerWelcomeViewState();
}

class _HajjTrackerWelcomeViewState extends State<HajjTrackerWelcomeView> {
  late final TextEditingController _nameController;

  static const Color _forest = Color(0xFF1B4332);
  static const Color _labelBar = Color(0xFF333333);

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: getIt<AppPreferences>().getHajjPilgrimNameSync(),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _continue() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'يرجى إدخال اسم الحاج',
            style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w700),
          ),
        ),
      );
      return;
    }
    await getIt<AppPreferences>().setHajjPilgrimName(name);
    if (!mounted) return;
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const HajjTrackerInstructionsView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage(ImageAssets.generalIhdaa),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withValues(alpha: 0.35),
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Column(
                      children: [
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: _forest,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.25),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: Image.asset(
                              ImageAssets.icon,
                              width: 44,
                              height: 44,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'تكتل الماسي',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'بطاقة متابعة أعمال الحج',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _forest,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w900,
                        fontSize: 26,
                        height: 1.25,
                        shadows: const [
                          Shadow(
                            color: Colors.white,
                            blurRadius: 18,
                            offset: Offset(0, 0),
                          ),
                          Shadow(
                            color: Colors.white,
                            blurRadius: 6,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: const BoxDecoration(
                            color: _labelBar,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(14),
                            ),
                          ),
                          child: const Text(
                            'اسم الحاج',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.white,
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(14),
                          ),
                          child: TextField(
                            controller: _nameController,
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              hintText: 'اكتب الاسم هنا',
                              hintStyle: TextStyle(
                                color: Color(0xFF9E9E9E),
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    FilledButton(
                      onPressed: _continue,
                      style: FilledButton.styleFrom(
                        backgroundColor: _forest,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'متابعة',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'جميع الحقوق محفوظة — تكتل الماسي ١٤٤٧ هـ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.92),
                        fontFamily: 'Cairo',
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        shadows: const [
                          Shadow(
                            color: Colors.black54,
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white.withValues(alpha: 0.95),
                        ),
                        tooltip: 'رجوع',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
