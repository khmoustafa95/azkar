import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:holly_quran/core/resources/app_assets.dart';

/// Fails if any path returned by [allBundledMemberAndGroupImagePaths] is missing
/// under the project root. Run before release:
/// `flutter test test/asset_paths_exist_test.dart`
void main() {
  test('registered member and group image files exist on disk', () {
    final root = Directory.current.path;
    final missing = <String>[];

    for (final assetPath in allBundledMemberAndGroupImagePaths()) {
      final file = File('$root/$assetPath');
      if (!file.existsSync()) {
        missing.add(assetPath);
      }
    }

    expect(
      missing,
      isEmpty,
      reason:
          'Missing ${missing.length} asset file(s). Add files under the project '
          'root or fix paths in lib/core/resources/app_assets.dart.\n'
          '${missing.map((p) => '  - $p').join('\n')}',
    );
  });
}
