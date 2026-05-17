// Lists asset files on disk not referenced in lib/test/pubspec or app_assets registries.
//
//   dart run tool/find_unused_assets.dart

import 'dart:io';

import 'package:holly_quran/core/resources/app_assets.dart';

final _skipDirNames = {'_backup_videos', '_backup_audio', '_backup_images'};

void main() {
  final root = Directory.current;
  final libAndTest = _readSources(root, ['lib', 'test']);
  final pubspec = File('pubspec.yaml').readAsStringSync();
  final literalBlob = '$libAndTest\n$pubspec';

  final registered = _allRegisteredPaths();
  final registeredSet = registered.map((p) => p.replaceAll('\\', '/')).toSet();
  final onDisk = _listAssetFiles(root);

  final unusedOnDisk = <String>[];
  for (final path in onDisk) {
    final normalized = path.replaceAll('\\', '/');
    if (registeredSet.contains(normalized)) continue;
    if (_isReferencedLiterally(normalized, literalBlob)) continue;
    unusedOnDisk.add(normalized);
  }

  stdout.writeln('=== Unused files on disk (${unusedOnDisk.length}) ===');
  unusedOnDisk.sort();
  var totalBytes = 0;
  for (final p in unusedOnDisk) {
    final len = File(p).lengthSync();
    totalBytes += len;
    stdout.writeln('  ${(len / 1024).toStringAsFixed(1)} KB  $p');
  }
  stdout.writeln(
    '\nTotal reclaimable: ${(totalBytes / (1024 * 1024)).toStringAsFixed(2)} MB',
  );
  stdout.writeln('\nRegistered paths counted as used: ${registeredSet.length}');
}

String _readSources(Directory root, List<String> dirs) {
  final buf = StringBuffer();
  for (final dirName in dirs) {
    final dir = Directory('${root.path}/$dirName');
    if (!dir.existsSync()) continue;
    for (final entity in dir.listSync(recursive: true)) {
      if (entity is File && entity.path.endsWith('.dart')) {
        buf.writeln(entity.readAsStringSync());
      }
    }
  }
  return buf.toString();
}

List<String> _listAssetFiles(Directory root) {
  final assetsDir = Directory('${root.path}/assets');
  if (!assetsDir.existsSync()) return [];

  final out = <String>[];
  for (final entity in assetsDir.listSync(recursive: true)) {
    if (entity is! File) continue;
    final parts = entity.path.split(Platform.pathSeparator);
    if (parts.any(_skipDirNames.contains)) continue;
    if (entity.path.endsWith('.md')) continue;
    out.add(entity.path.substring(root.path.length + 1).replaceAll('\\', '/'));
  }
  return out;
}

bool _isReferencedLiterally(String assetPath, String blob) {
  if (blob.contains(assetPath)) return true;
  final name = assetPath.split('/').last;
  return name.length >= 8 && blob.contains(name);
}

List<String> _allRegisteredPaths() {
  return [
    ...MemberImageAssets.bundledPaths,
    ...GroupSvgAssets.bundledPaths,
    ...SoundPrayerAudioAssets.bundledPaths,
    ...TextPrayerImageAssets.bundledPaths,
    ...WithHajjVideoAssets.bundledPaths,
    ...DoYouKnowVideoAssets.bundledPaths,
    ...FiqhHajj1VideoAssets.bundledPaths,
    ...FighHajj2VideoAssets.bundledPaths,
    ...AdminInstructionImageAssets.bundledPaths,
    ...AdminAdviceImageAssets.bundledPaths,
    ...QuranMushafPageAssets.allPaths,
    VideoAssets.whoWeAre,
    ImageAssets.background,
    ImageAssets.icon,
    ImageAssets.dua,
    ImageAssets.home,
    ImageAssets.arrow,
    ImageAssets.azkarMasaa,
    ImageAssets.hesnMuslim,
    ImageAssets.dayWheelMark,
    ImageAssets.generalIhdaa,
    ImageAssets.about,
    ImageAssets.share,
    ImageAssets.frontCard,
    ImageAssets.backCard,
    ...IconAssets.all,
    'assets/images/icon.png',
    'assets/icon/logo.jpeg',
    'assets/json/quran_surahs.json',
  ];
}
