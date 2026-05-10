// Verify registered member/group image paths exist on disk.
//
// From the project root:
//   dart run tool/verify_assets.dart
//
// Same checks as: flutter test test/asset_paths_exist_test.dart

import 'dart:io';

import 'package:holly_quran/core/resources/app_assets.dart';

void main() {
  final root = Directory.current.path;
  final missing = <String>[];

  for (final assetPath in allBundledMemberAndGroupImagePaths()) {
    final file = File('$root/$assetPath');
    if (!file.existsSync()) {
      missing.add(assetPath);
    }
  }

  if (missing.isNotEmpty) {
    stderr.writeln(
      'verify_assets: ${missing.length} missing file(s) under project root:',
    );
    for (final p in missing) {
      stderr.writeln('  $p');
    }
    stderr.writeln(
      '\nFix: add the files or update MemberImageAssets / GroupImageAssets '
      'in lib/core/resources/app_assets.dart (and keep bundledPaths in sync).',
    );
    exit(1);
  }

  stdout.writeln(
    'verify_assets: OK — ${allBundledMemberAndGroupImagePaths().length} '
    'registered member/group paths exist on disk.',
  );
}
