import 'package:flutter/widgets.dart';

/// A single slide in a [SlideShow] / [ImmersiveSlideShow].
///
/// Designed to be data-only and immutable so that lists of slides can live
/// in `const` collections at compile time.
@immutable
class SlideItem {
  const SlideItem({
    required this.asset,
    this.title,
    this.semanticsLabel,
  });

  /// Asset path under one of the project's registered asset folders, e.g.
  /// `assets/admin_instructions/06_mosque.jpg`.
  final String asset;

  /// Optional human-readable title for this slide (used in counters, share
  /// sheets, or accessibility hints). The image itself usually already
  /// embeds the title, so this field is informational only.
  final String? title;

  /// Optional override for the accessibility label. Falls back to [title]
  /// when null.
  final String? semanticsLabel;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SlideItem &&
          other.asset == asset &&
          other.title == title &&
          other.semanticsLabel == semanticsLabel;

  @override
  int get hashCode => Object.hash(asset, title, semanticsLabel);
}
