import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:holly_quran/core/extension/extensions.dart';
import 'package:holly_quran/core/helper_functions/ui_feedback.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/resources/values_manager.dart';

class PhoneWidget extends StatelessWidget {
  const PhoneWidget({super.key, required this.phone, this.saPhone});
  final String phone;
  final String? saPhone;

  Future<void> _launchWhatsApp(
    BuildContext context,
    String number,
  ) async {
    final messenger = ScaffoldMessenger.maybeOf(context);
    final uri = Uri.parse('https://wa.me/$number');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
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
    final uri = Uri.parse('tel:$number');
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
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSize.s16),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: AppSize.s8),
            child: Text(
              "SY: ${phone.toFormattedPhone()}",
              textDirection: TextDirection.ltr,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () => _launchWhatsApp(context, phone),
                    child: const Icon(
                      FontAwesomeIcons.whatsapp,
                      color: Colors.green,
                      size: 24,
                    ),
                  ),
                  const Text('مراسلة', style: TextStyle(fontSize: 10)),
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () => _launchDialer(context, phone),
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
          if (saPhone != null) ...[
            Divider(
              color: Colors.grey,
              thickness: 1,
              endIndent: context.width * 0.05,
              indent: context.width * 0.05,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: AppSize.s8),
              child: Text(
                "SA: ${saPhone!.toFormattedPhone()}",
                textDirection: TextDirection.ltr,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () => _launchWhatsApp(context, saPhone!),
                      child: const Icon(
                        FontAwesomeIcons.whatsapp,
                        color: Colors.green,
                        size: 24,
                      ),
                    ),
                    const Text('مراسلة', style: TextStyle(fontSize: 10)),
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () => _launchDialer(context, saPhone!),
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
        ],
      ),
    );
  }
}
