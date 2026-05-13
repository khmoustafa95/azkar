import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:holly_quran/features/home/data/communication_channel.dart';
import 'package:holly_quran/features/home/data/communication_group_options.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens a bottom sheet to collect guest + group + category + details, then
/// copy to clipboard and/or open WhatsApp with a prefilled message.
Future<void> showContactRequestSheet(
  BuildContext context, {
  required CommunicationChannel channel,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => _ContactRequestSheetBody(channel: channel),
  );
}

class _ContactRequestSheetBody extends StatefulWidget {
  const _ContactRequestSheetBody({required this.channel});

  final CommunicationChannel channel;

  @override
  State<_ContactRequestSheetBody> createState() =>
      _ContactRequestSheetBodyState();
}

class _ContactRequestSheetBodyState extends State<_ContactRequestSheetBody> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _detailsCtrl;

  CommunicationGroupOption? _group;
  String? _category;

  static const Color _darkGreen = Color(0xFF083A30);
  static const Color _muted = Color(0xFF6B7570);

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController();
    _detailsCtrl = TextEditingController();
    _group = kCommunicationGroupOptions.first;
    _category = widget.channel.categoryOptions.first;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _detailsCtrl.dispose();
    super.dispose();
  }

  String _composeMessage() {
    final buf = StringBuffer()
      ..writeln('السلام عليكم ورحمة الله وبركاته')
      ..writeln()
      ..writeln('【${widget.channel.title}】')
      ..writeln('الاسم: ${_nameCtrl.text.trim()}')
      ..writeln('المجموعة: ${_group?.name ?? ''}')
      ..writeln('${widget.channel.typeFieldLabel}: ${_category ?? ''}')
      ..writeln()
      ..writeln('التفاصيل / الموضوع:')
      ..writeln(_detailsCtrl.text.trim());
    return buf.toString();
  }

  String _truncateForWhatsApp(String text, {int maxChars = 1550}) {
    if (text.length <= maxChars) return text;
    return '${text.substring(0, maxChars)}\n\n...(تم اختصار النص لحد واتساب)';
  }

  Future<void> _copyOnly() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final msg = _composeMessage();
    await Clipboard.setData(ClipboardData(text: msg));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'تم نسخ الرسالة. يمكنك لصقها في واتساب عند الحاجة.',
          style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w700),
        ),
      ),
    );
    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _openWhatsApp() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final msg = _truncateForWhatsApp(_composeMessage());
    final uri = Uri.parse(
      'https://wa.me/${widget.channel.waDigits}?text=${Uri.encodeComponent(msg)}',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (mounted) Navigator.of(context).pop();
      return;
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'تعذر فتح واتساب على هذا الجهاز',
          style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final ch = widget.channel;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomInset),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * 0.92,
          ),
          margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 24,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: ch.accentColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(ch.icon, color: ch.accentColor, size: 26),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ch.title,
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w900,
                              fontSize: 17,
                              color: _darkGreen,
                            ),
                          ),
                          Text(
                            ch.sheetSubtitle,
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: _muted,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: _nameCtrl,
                          textAlign: TextAlign.right,
                          decoration: const InputDecoration(
                            labelText: 'اسمك الكريم',
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(fontFamily: 'Cairo'),
                          ),
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w600,
                          ),
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'يرجى إدخال الاسم';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),
                        DropdownButtonFormField<CommunicationGroupOption>(
                          initialValue: _group,
                          decoration: const InputDecoration(
                            labelText: 'اسم المجموعة',
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(fontFamily: 'Cairo'),
                          ),
                          items: kCommunicationGroupOptions
                              .map(
                                (g) => DropdownMenuItem(
                                  value: g,
                                  child: Text(
                                    g.name,
                                    style: const TextStyle(
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (v) => setState(() => _group = v),
                          validator: (v) => v == null ? 'اختر المجموعة' : null,
                        ),
                        const SizedBox(height: 14),
                        DropdownButtonFormField<String>(
                          initialValue: _category,
                          decoration: InputDecoration(
                            labelText: ch.typeFieldLabel,
                            border: const OutlineInputBorder(),
                            labelStyle: const TextStyle(fontFamily: 'Cairo'),
                          ),
                          items: ch.categoryOptions
                              .map(
                                (c) => DropdownMenuItem(
                                  value: c,
                                  child: Text(
                                    c,
                                    style: const TextStyle(
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (v) => setState(() => _category = v),
                          validator: (v) =>
                              v == null || v.isEmpty ? 'اختر النوع' : null,
                        ),
                        const SizedBox(height: 14),
                        TextFormField(
                          controller: _detailsCtrl,
                          textAlign: TextAlign.right,
                          minLines: 3,
                          maxLines: 6,
                          decoration: const InputDecoration(
                            labelText: 'التفاصيل / الموضوع',
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(fontFamily: 'Cairo'),
                          ),
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w600,
                            height: 1.4,
                          ),
                          validator: (v) {
                            if (v == null || v.trim().length < 4) {
                              return 'يرجى كتابة تفاصيل كافية (4 أحرف على الأقل)';
                            }
                            return null;
                          },
                        ),
                        // const SizedBox(height: 8),
                        // Text(
                        //   'جهاز اللوحي: لا تُخزَّن بياناتك في التطبيق بعد الإغلاق. '
                        //   'يُفضّل مراجعة الرسالة قبل الإرسال.',
                        //   style: TextStyle(
                        //     fontFamily: 'Cairo',
                        //     fontSize: 11,
                        //     color: _muted.withValues(alpha: 0.95),
                        //     height: 1.35,
                        //   ),
                        // ),
                        const SizedBox(height: 18),
                        OutlinedButton.icon(
                          onPressed: _copyOnly,
                          icon: const Icon(Icons.send_outlined),
                          label: const Text(
                            'إرسال (نسخ للواتساب)',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: ch.accentColor,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                        const SizedBox(height: 10),
                        FilledButton.icon(
                          onPressed: _openWhatsApp,
                          icon: const Icon(Icons.chat_rounded),
                          label: const Text(
                            'إرسال وفتح واتساب',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          style: FilledButton.styleFrom(
                            backgroundColor: ch.accentColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
