import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:holly_quran/core/extension/extensions.dart';
import 'package:holly_quran/core/helper_functions/phone_country.dart';
import 'package:holly_quran/core/helper_functions/ui_feedback.dart';
import 'package:holly_quran/core/helper_functions/whatsapp_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/resources/values_manager.dart';

class PhoneWidget extends StatelessWidget {
  const PhoneWidget({
    super.key,
    this.phone,
    this.saPhone,
    this.trPhone,
    List<String>? phones,
  }) : _phones = phones;

  /// Syria line (legacy field — flag is inferred from the number prefix).
  final String? phone;

  /// Saudi line (optional).
  final String? saPhone;

  /// Turkey line (optional).
  final String? trPhone;

  final List<String>? _phones;

  List<String> get _resolvedPhones => _phones ??
      collectPhoneNumbers(primary: phone, saudi: saPhone, turkey: trPhone);

  Future<void> _launchWhatsApp(
    BuildContext context,
    String number,
  ) async {
    final messenger = ScaffoldMessenger.maybeOf(context);
    try {
      final opened = await openWhatsAppChat(number);
      if (!opened) {
        showAppSnackBarFromMessenger(
          messenger,
          message: 'لا يمكن فتح واتساب على هذا الجهاز',
          isError: true,
        );
      }
    } catch (_) {
      showAppSnackBarFromMessenger(
        messenger,
        message: 'تعذر فتح واتساب',
        isError: true,
      );
    }
  }

  Future<void> _launchDialer(
    BuildContext context,
    String number,
  ) async {
    final messenger = ScaffoldMessenger.maybeOf(context);
    final uri = Uri.parse('tel:${normalizePhoneNumber(number)}');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.platformDefault);
      } else {
        showAppSnackBarFromMessenger(
          messenger,
          message: 'لا يمكن فتح تطبيق الهاتف على هذا الجهاز',
          isError: true,
        );
      }
    } catch (_) {
      showAppSnackBarFromMessenger(
        messenger,
        message: 'تعذر إجراء الاتصال',
        isError: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final numbers = _resolvedPhones;
    if (numbers.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSize.s16),
      child: Column(
        children: [
          for (var i = 0; i < numbers.length; i++) ...[
            if (i > 0)
              Divider(
                color: Colors.grey,
                thickness: 1,
                endIndent: context.width * 0.05,
                indent: context.width * 0.05,
              ),
            _PhoneSection(
              number: numbers[i],
              onWhatsApp: () => _launchWhatsApp(context, numbers[i]),
              onDial: () => _launchDialer(context, numbers[i]),
            ),
          ],
        ],
      ),
    );
  }
}

class _PhoneSection extends StatelessWidget {
  const _PhoneSection({
    required this.number,
    required this.onWhatsApp,
    required this.onDial,
  });

  final String number;
  final VoidCallback onWhatsApp;
  final VoidCallback onDial;

  @override
  Widget build(BuildContext context) {
    final flagAsset = flagAssetForPhone(number);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: AppSize.s8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            textDirection: TextDirection.ltr,
            children: [
              _RoundFlag(assetPath: flagAsset),
              const SizedBox(width: AppSize.s8),
              Flexible(
                child: Text(
                  number.toFormattedPhone(),
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                InkWell(
                  onTap: onWhatsApp,
                  child: const Icon(
                    Icons.chat_rounded,
                    color: Color(0xFF25D366),
                    size: 24,
                  ),
                ),
                const Text('مراسلة', style: TextStyle(fontSize: 10)),
              ],
            ),
            Column(
              children: [
                InkWell(
                  onTap: onDial,
                  child: const Icon(
                    Icons.call_outlined,
                    color: Colors.green,
                    size: 24,
                  ),
                ),
                const Text('اتصال', style: TextStyle(fontSize: 10)),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _RoundFlag extends StatelessWidget {
  const _RoundFlag({required this.assetPath});

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: AppSize.s28,
        height: AppSize.s28,
        child: SvgPicture.asset(
          assetPath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
