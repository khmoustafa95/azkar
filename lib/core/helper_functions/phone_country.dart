import 'package:holly_quran/core/resources/app_assets.dart';

enum PhoneRegion { syria, saudi, turkey, unknown }

/// Normalizes dial strings for parsing and [Uri] launchers.
String normalizePhoneNumber(String raw) {
  var clean = raw.replaceAll(RegExp(r'[^\d+]'), '');
  while (clean.startsWith('++')) {
    clean = clean.replaceFirst('++', '+');
  }
  if (!clean.startsWith('+') && clean.isNotEmpty) {
    clean = '+$clean';
  }
  return clean;
}

/// Infers region from international prefix (+963, +966, +90).
PhoneRegion phoneRegionFor(String raw) {
  final clean = normalizePhoneNumber(raw);
  if (clean.startsWith('+90') || clean.startsWith('90')) {
    return PhoneRegion.turkey;
  }
  if (clean.startsWith('+966') || clean.startsWith('966')) {
    return PhoneRegion.saudi;
  }
  if (clean.startsWith('+963') || clean.startsWith('963')) {
    return PhoneRegion.syria;
  }
  return PhoneRegion.unknown;
}

String flagAssetForPhone(String raw) {
  switch (phoneRegionFor(raw)) {
    case PhoneRegion.syria:
      return IconAssets.sy;
    case PhoneRegion.saudi:
      return IconAssets.sa;
    case PhoneRegion.turkey:
      return IconAssets.tur;
    case PhoneRegion.unknown:
      return IconAssets.sy;
  }
}

/// Unique non-empty numbers in display order.
List<String> collectPhoneNumbers({
  String? primary,
  String? saudi,
  String? turkey,
  List<String>? extra,
}) {
  final seen = <String>{};
  final out = <String>[];

  void add(String? value) {
    if (value == null) return;
    final normalized = normalizePhoneNumber(value.trim());
    if (normalized.isEmpty || seen.contains(normalized)) return;
    seen.add(normalized);
    out.add(value.trim());
  }

  add(primary);
  add(saudi);
  add(turkey);
  if (extra != null) {
    for (final n in extra) {
      add(n);
    }
  }
  return out;
}
