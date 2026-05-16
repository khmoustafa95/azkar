import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:holly_quran/core/resources/app_routers.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/home/data/models/duaa/duaa_model.dart';

/// List tile for a single [DuaaModel]: title + media-type icon, app styling.
class DuaaContentListTile extends StatelessWidget {
  const DuaaContentListTile({
    super.key,
    required this.duaa,
    this.onTap,
  });

  final DuaaModel duaa;
  final VoidCallback? onTap;

  static const Color _darkGreen = Color(0xFF083A30);
  static const Color _ink = Color(0xFF1A2421);

  static IconData iconForType(String type) {
    switch (type) {
      case 'audio':
        return Icons.mic_rounded;
      case 'slideshow':
      case 'image':
        return Icons.photo_library_rounded;
      case 'video':
      default:
        return Icons.videocam_rounded;
    }
  }

  static Color accentForCategory(String category) {
    switch (category) {
      case DuaaContentCategory.fiqhHajj:
        return const Color(0xFF1E5A7A);
      case DuaaContentCategory.audioDuas:
        return const Color(0xFF2D6A4F);
      case DuaaContentCategory.fiqhMessages:
        return const Color(0xFFB85A33);
      case DuaaContentCategory.pilgrimAdvice:
        return const Color(0xFF8B6914);
      default:
        return _darkGreen;
    }
  }

  void _defaultTap(BuildContext context) {
    GoRouter.of(context).pushNamed(
      Routes.duaaDetailsRoute,
      pathParameters: {'id1': '${duaa.id}'},
      extra: duaa.toJson(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final accent = accentForCategory(duaa.category);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.p10),
      child: Material(
        color: Colors.white,
        elevation: 2,
        shadowColor: const Color(0x22000000),
        borderRadius: BorderRadius.circular(AppSize.s16),
        child: InkWell(
          onTap: onTap ?? () => _defaultTap(context),
          borderRadius: BorderRadius.circular(AppSize.s16),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s16),
              border: Border.all(
                color: accent.withValues(alpha: 0.28),
                width: 1.2,
              ),
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
                  accent.withValues(alpha: 0.09),
                  Colors.white,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p14,
                vertical: AppPadding.p12,
              ),
              child: Row(
                children: [
                  _TypeIconBadge(
                    icon: iconForType(duaa.type),
                    color: accent,
                  ),
                  const SizedBox(width: AppSize.s12),
                  Expanded(
                    child: Text(
                      duaa.name,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: _ink,
                        fontFamily: 'Cairo',
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        height: 1.25,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSize.s8),
                  Icon(
                    Icons.chevron_left_rounded,
                    color: accent,
                    size: 22,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TypeIconBadge extends StatelessWidget {
  const _TypeIconBadge({
    required this.icon,
    required this.color,
  });

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.s50,
      height: AppSize.s50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        shape: BoxShape.circle,
        border: Border.all(
          color: color.withValues(alpha: 0.45),
          width: 1.3,
        ),
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }
}
