import 'package:holly_quran/core/helper_functions/phone_country.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens WhatsApp for [rawNumber]. Tries app deep link then https://wa.me/.
///
/// Do not rely on [canLaunchUrl] alone — on Android 11+ it returns false
/// unless matching `<queries>` are declared in AndroidManifest.xml.
Future<bool> openWhatsAppChat(
  String rawNumber, {
  String? prefilledMessage,
}) async {
  final digits = normalizePhoneNumber(rawNumber).replaceAll(RegExp(r'\D'), '');
  if (digits.isEmpty) return false;

  final message = prefilledMessage?.trim();
  final hasMessage = message != null && message.isNotEmpty;
  final encodedText = hasMessage ? Uri.encodeComponent(message) : null;

  final uris = <Uri>[
    if (encodedText != null)
      Uri.parse('whatsapp://send?phone=$digits&text=$encodedText')
    else
      Uri.parse('whatsapp://send?phone=$digits'),
    if (encodedText != null)
      Uri.parse('https://wa.me/$digits?text=$encodedText')
    else
      Uri.parse('https://wa.me/$digits'),
  ];

  for (final uri in uris) {
    try {
      if (await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        return true;
      }
    } catch (_) {
      continue;
    }
  }
  return false;
}
