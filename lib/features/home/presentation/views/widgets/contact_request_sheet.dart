import 'package:flutter/material.dart';
import 'package:holly_quran/core/helper_functions/whatsapp_launcher.dart';
import 'package:holly_quran/features/home/data/communication_channel.dart';
import 'package:holly_quran/features/home/data/communication_group_options.dart';

const Color _kSheetDarkGreen = Color(0xFF083A30);
const Color _kSheetMuted = Color(0xFF6B7570);

/// Bottom sheet: guest details → open WhatsApp with prefilled message.
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

final List<DropdownMenuItem<CommunicationGroupOption>> _groupMenuItems =
    kCommunicationGroupOptions
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
        .toList(growable: false);

List<DropdownMenuItem<String>> _categoryMenuItems(CommunicationChannel ch) => ch
    .categoryOptions
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
    .toList(growable: false);

class _ContactRequestSheetBody extends StatefulWidget {
  const _ContactRequestSheetBody({required this.channel});

  final CommunicationChannel channel;

  @override
  State<_ContactRequestSheetBody> createState() =>
      _ContactRequestSheetBodyState();
}

class _ContactRequestSheetBodyState extends State<_ContactRequestSheetBody> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _detailsCtrl = TextEditingController();

  late CommunicationGroupOption _group;
  late String _category;
  late final List<DropdownMenuItem<String>> _categoryItems;

  bool _sending = false;

  CommunicationChannel get _ch => widget.channel;

  @override
  void initState() {
    super.initState();
    _group = kCommunicationGroupOptions.first;
    _category = _ch.categoryOptions.first;
    _categoryItems = _categoryMenuItems(_ch);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _detailsCtrl.dispose();
    super.dispose();
  }

  String _composeMessage() {
    return 'السلام عليكم ورحمة الله وبركاته\n\n'
        '【${_ch.title}】\n'
        'الاسم: ${_nameCtrl.text.trim()}\n'
        'المجموعة: ${_group.name}\n'
        '${_ch.typeFieldLabel}: $_category\n\n'
        'التفاصيل / الموضوع:\n'
        '${_detailsCtrl.text.trim()}';
  }

  String _truncateForWhatsApp(String text, {int maxChars = 1550}) {
    if (text.length <= maxChars) return text;
    return '${text.substring(0, maxChars)}\n\n...(تم اختصار النص لحد واتساب)';
  }

  Future<void> _openWhatsApp() async {
    if (_sending) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _sending = true);

    final msg = _truncateForWhatsApp(_composeMessage());
    final opened = await openWhatsAppChat(
      _ch.waDigits,
      prefilledMessage: msg,
    );

    if (!mounted) return;
    setState(() => _sending = false);

    if (opened) {
      Navigator.of(context).pop();
      return;
    }

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
    final maxH = MediaQuery.sizeOf(context).height * 0.92;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomInset),
        child: Container(
          constraints: BoxConstraints(maxHeight: maxH),
          margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color(0x2E000000),
                blurRadius: 12,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _SheetHeader(channel: _ch),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: _nameCtrl,
                          textInputAction: TextInputAction.next,
                          textAlign: TextAlign.right,
                          decoration: _fieldDecoration('اسمك الكريم'),
                          style: _fieldStyle,
                          validator: (v) => v == null || v.trim().isEmpty
                              ? 'يرجى إدخال الاسم'
                              : null,
                        ),
                        const SizedBox(height: 14),
                        DropdownButtonFormField<CommunicationGroupOption>(
                          initialValue: _group,
                          decoration: _fieldDecoration('اسم المجموعة'),
                          items: _groupMenuItems,
                          onChanged: (v) {
                            if (v != null) setState(() => _group = v);
                          },
                          validator: (v) => v == null ? 'اختر المجموعة' : null,
                        ),
                        const SizedBox(height: 14),
                        DropdownButtonFormField<String>(
                          initialValue: _category,
                          decoration: _fieldDecoration(_ch.typeFieldLabel),
                          items: _categoryItems,
                          onChanged: (v) {
                            if (v != null) setState(() => _category = v);
                          },
                          validator: (v) =>
                              v == null || v.isEmpty ? 'اختر النوع' : null,
                        ),
                        const SizedBox(height: 14),
                        TextFormField(
                          controller: _detailsCtrl,
                          textInputAction: TextInputAction.done,
                          textAlign: TextAlign.right,
                          minLines: 3,
                          maxLines: 5,
                          decoration: _fieldDecoration('التفاصيل / الموضوع'),
                          style: _fieldStyle,
                          validator: (v) => v == null || v.trim().length < 4
                              ? 'يرجى كتابة تفاصيل كافية (4 أحرف على الأقل)'
                              : null,
                        ),
                        const SizedBox(height: 18),
                        FilledButton.icon(
                          onPressed: _sending ? null : _openWhatsApp,
                          icon: _sending
                              ? SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white.withValues(alpha: 0.9),
                                  ),
                                )
                              : const Icon(Icons.chat_rounded),
                          label: Text(
                            _sending ? 'جاري الفتح...' : 'إرسال وفتح واتساب',
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          style: FilledButton.styleFrom(
                            backgroundColor: _ch.accentColor,
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

const _fieldStyle = TextStyle(
  fontFamily: 'Cairo',
  fontWeight: FontWeight.w600,
  height: 1.4,
);

InputDecoration _fieldDecoration(String label) => InputDecoration(
  labelText: label,
  alignLabelWithHint: true,
  border: const OutlineInputBorder(),
  labelStyle: const TextStyle(fontFamily: 'Cairo'),
);

class _SheetHeader extends StatelessWidget {
  const _SheetHeader({required this.channel});

  final CommunicationChannel channel;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  color: channel.accentColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(channel.icon, color: channel.accentColor, size: 26),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      channel.title,
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w900,
                        fontSize: 17,
                        color: _kSheetDarkGreen,
                      ),
                    ),
                    Text(
                      channel.sheetSubtitle,
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: _kSheetMuted,
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
      ],
    );
  }
}
