import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:holly_quran/core/helper_functions/responsive_layout.dart';
import 'package:holly_quran/core/resources/app_routers.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/home/data/models/duaa/duaa_model.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/duaa_content_list_tile.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/video_asset_thumbnail.dart';

/// Grid of video items with thumbnail previews.
class DuaaVideoGridView extends StatelessWidget {
  const DuaaVideoGridView({
    super.key,
    required this.items,
    required this.searchQuery,
    required this.onSearchChanged,
  });

  final List<DuaaModel> items;
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppPadding.p16,
            AppPadding.p12,
            AppPadding.p16,
            AppPadding.p8,
          ),
          child: TextField(
            onChanged: onSearchChanged,
            decoration: const InputDecoration(
              labelText: 'بحث..',
              suffixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
              labelStyle: TextStyle(fontFamily: 'Cairo'),
            ),
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: items.isEmpty
              ? const Center(
                  child: Text(
                    'لا توجد نتائج',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                )
              : LayoutBuilder(
                  builder: (context, constraints) {
                    final cols = Responsive.gridColumns(context);
                    return GridView.builder(
                  padding: const EdgeInsets.fromLTRB(
                    AppPadding.p12,
                    0,
                    AppPadding.p12,
                    AppPadding.p20,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: cols,
                    crossAxisSpacing: AppSize.s12,
                    mainAxisSpacing: AppSize.s12,
                    childAspectRatio:
                        Responsive.isTablet(context) ? 0.85 : 0.78,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final duaa = items[index];
                    final accent =
                        DuaaContentListTile.accentForCategory(duaa.category);
                    return _VideoGridTile(duaa: duaa, accent: accent);
                  },
                );
                  },
                ),
        ),
      ],
    );
  }
}

class _VideoGridTile extends StatelessWidget {
  const _VideoGridTile({
    required this.duaa,
    required this.accent,
  });

  final DuaaModel duaa;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 2,
      shadowColor: const Color(0x22000000),
      borderRadius: BorderRadius.circular(AppSize.s14),
      child: InkWell(
        onTap: () {
          GoRouter.of(context).pushNamed(
            Routes.duaaDetailsRoute,
            pathParameters: {'id1': '${duaa.id}'},
            extra: duaa.toJson(),
          );
        },
        borderRadius: BorderRadius.circular(AppSize.s14),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s14),
            border: Border.all(color: accent.withValues(alpha: 0.25)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppSize.s14),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      VideoAssetThumbnail(
                        assetPath: duaa.url,
                        iconColor: accent,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.45),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(AppPadding.p10),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.92),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.play_arrow_rounded,
                            color: accent,
                            size: 32,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppPadding.p10,
                  AppPadding.p8,
                  AppPadding.p10,
                  AppPadding.p10,
                ),
                child: Text(
                  duaa.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A2421),
                    height: 1.25,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
