import 'package:flutter/material.dart';
import 'package:holly_quran/core/resources/values_manager.dart';

/// Breakpoints and helpers for phone vs tablet layouts.
abstract final class Responsive {
  static const double tabletBreakpoint = 600;
  static const double largeTabletBreakpoint = 840;

  static Size sizeOf(BuildContext context) => MediaQuery.sizeOf(context);

  static double shortestSide(BuildContext context) =>
      sizeOf(context).shortestSide;

  static bool isTablet(BuildContext context) =>
      shortestSide(context) >= tabletBreakpoint;

  static bool isLargeTablet(BuildContext context) =>
      shortestSide(context) >= largeTabletBreakpoint;

  /// Max content width so lines/cards do not stretch on wide tablets.
  static double contentMaxWidth(BuildContext context) {
    if (isLargeTablet(context)) return 720;
    if (isTablet(context)) return 600;
    return double.infinity;
  }

  /// Grid columns: 2 phone, 3 tablet, 4 large tablet (capped by [max]).
  static int gridColumns(
    BuildContext context, {
    int phone = 2,
    int tablet = 3,
    int largeTablet = 4,
    int? max,
  }) {
    var cols = phone;
    if (isLargeTablet(context)) {
      cols = largeTablet;
    } else if (isTablet(context)) {
      cols = tablet;
    }
    if (max != null && cols > max) cols = max;
    return cols;
  }

  /// Group/member carousel height — capped on tall tablets.
  static double groupCarouselHeight(BuildContext context) {
    final h = sizeOf(context).height;
    if (isTablet(context)) {
      return (h * 0.48).clamp(360.0, 480.0);
    }
    return (h * 0.58).clamp(300.0, 520.0);
  }

  static double groupCarouselViewportFraction(BuildContext context) {
    if (isLargeTablet(context)) return 0.35;
    if (isTablet(context)) return 0.42;
    return 0.6;
  }

  static double memberCarouselHeight(BuildContext context) {
    final h = sizeOf(context).height;
    if (isTablet(context)) {
      return (h * 0.52).clamp(380.0, 500.0);
    }
    return (h * 0.62).clamp(320.0, 540.0);
  }

  /// Bottom padding above docked FAB on home tab.
  static double homeScrollBottomPadding(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;
    return AppSize.s100 + bottom;
  }
}

/// Centers content and limits width on tablets.
class ResponsiveBody extends StatelessWidget {
  const ResponsiveBody({
    super.key,
    required this.child,
    this.padding,
    this.alignment = Alignment.topCenter,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: Responsive.contentMaxWidth(context),
        ),
        child: padding != null
            ? Padding(padding: padding!, child: child)
            : child,
      ),
    );
  }
}
