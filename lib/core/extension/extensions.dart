import 'package:flutter/material.dart';

extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return '';
    } else {
      return this!;
    }
  }
}

extension NonNullInteger on int? {
  int orZero() {
    if (this == null) {
      return 0;
    } else {
      return this!;
    }
  }
}

extension MediaQueryValue on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  double get toPadding => MediaQuery.of(this).viewPadding.top;
  double get bottom => MediaQuery.of(this).viewInsets.bottom;
}

extension PhoneFormatter on String {
  String toFormattedPhone() {
    final clean = replaceAll(RegExp(r'[^\d+]'), '');
    var normalized = clean;
    while (normalized.startsWith('++')) {
      normalized = normalized.replaceFirst('++', '+');
    }

    if (!normalized.startsWith('+')) return normalized;

    if (normalized.startsWith('+90') && normalized.length >= 12) {
      return '+90 ${normalized.substring(3, 6)} ${normalized.substring(6, 9)} ${normalized.substring(9)}';
    }
    if (normalized.startsWith('+963') && normalized.length >= 12) {
      return '+963 ${normalized.substring(4, 7)} ${normalized.substring(7, 10)} ${normalized.substring(10)}';
    }
    if (normalized.startsWith('+966') && normalized.length >= 12) {
      return '+966 ${normalized.substring(4, 6)} ${normalized.substring(6, 9)} ${normalized.substring(9)}';
    }

    final countryCode = normalized.length >= 4
        ? normalized.substring(0, 4)
        : normalized;
    final rest = normalized.length >= 4 ? normalized.substring(4) : '';
    final chunks =
        RegExp(r'.{1,3}').allMatches(rest).map((m) => m.group(0)).join(' ');
    return chunks.isEmpty ? countryCode : '$countryCode $chunks';
  }
}
