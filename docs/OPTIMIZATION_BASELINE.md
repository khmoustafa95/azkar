# App size optimization results

Branch: `optimized_version3`

## Before

| Metric | Size |
|--------|------|
| Release APK | 698.8 MB |
| Total bundled `assets/` | 652.3 MB |
| Videos (73 × `.mp4`) | 477.7 MB |
| Admin JPEGs | 70.9 MB |
| Audio (28 × `.mp3`) | 38.5 MB |

## After

| Metric | Size | Change |
|--------|------|--------|
| **Release APK** | **425.2 MB** | **−39% (−274 MB)** |
| Bundled `assets/` (excl. `_backup_*`) | 377.4 MB | −42% |
| Videos (72 × `.mp4`) | 284.4 MB | −40% |
| Admin images (WebP) | ~11 MB | −85% |
| Audio (26 × `.mp3`) | 18.3 MB | −53% |

## Changes applied

### Phase 1 — Code & dependencies
- Removed ~34k-line dead `quran_text.dart`, notification refactor stubs, unused `state_renderer/`, `dio`/`ApiService`, commented files
- Removed unused packages: YouTube stack, `signature`, `expansion_tile_list`, `flutter_packages_remover`, `dio`, `flutter_local_notifications`, `timezone`, `intl`, `lottie`
- Moved `flutter_native_splash` to `dev_dependencies`
- Pruned `app_assets.dart` (missing member placeholders, unused constants)
- Deleted orphan `assets/media/`, `assets/videos/video1.mp4`
- SDK constraint updated to Dart 3.9+

### Phase 2 — Media (ffmpeg)
- Videos: 720p max, H.264 CRF 32, AAC 96k (`tool/compress_videos.ps1`)
- Audio: mono 64k MP3 (`tool/compress_audio.ps1`)
- Admin slideshow: JPEG → WebP q85 (`tool/convert_admin_images_webp.ps1`)

Originals backed up under `assets/_backup_*` (gitignored, not bundled in APK).

## Out of scope
- `assets/quran_data/` mushaf pages (604 images) — deferred

## Find / remove unused assets

```powershell
dart run tool/find_unused_assets.dart
```

Lists files on disk not referenced in code or `app_assets.dart` registries. Because `pubspec.yaml` uses folder globs (e.g. `assets/images/`), **every file in that folder is bundled** even if unused.

## Re-run compression scripts
```powershell
cd "d:\Masi App\azkar"
.\tool\compress_videos.ps1
.\tool\compress_audio.ps1
.\tool\convert_admin_images_webp.ps1
```
