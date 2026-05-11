import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Renders an asset image by path, automatically picking [SvgPicture.asset]
/// for `.svg` files and [Image.asset] for raster formats (png/jpg/jpeg/webp).
///
/// Use this anywhere a group logo is shown so callers don't have to care
/// whether the underlying asset is vector or raster.
class GroupLogoImage extends StatelessWidget {
  const GroupLogoImage(
    this.assetPath, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.color,
    this.semanticLabel,
  });

  final String assetPath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;
  final String? semanticLabel;

  bool get _isSvg => assetPath.toLowerCase().endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    if (_isSvg) {
      return SvgPicture.asset(
        assetPath,
        width: width,
        height: height,
        fit: fit,
        colorFilter:
            color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn),
        semanticsLabel: semanticLabel,
      );
    }
    return Image.asset(
      assetPath,
      width: width,
      height: height,
      fit: fit,
      color: color,
      semanticLabel: semanticLabel,
    );
  }
}
