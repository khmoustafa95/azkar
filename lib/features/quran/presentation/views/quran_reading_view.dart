import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holly_quran/core/helper_functions/functions.dart';
import 'package:holly_quran/features/home/data/models/quran/surah_model.dart';
import 'package:holly_quran/features/quran/data/quran_juz_list.dart';
import 'package:holly_quran/features/quran/presentation/cubit/quran_cubit.dart';

/// Full-screen mushaf reader (604 PNG pages) with جزء jump and resume.
class QuranReadingView extends StatefulWidget {
  const QuranReadingView({super.key});

  @override
  State<QuranReadingView> createState() => _QuranReadingViewState();
}

class _QuranReadingViewState extends State<QuranReadingView> {
  PageController? _pageController;
  int _displayPage = 1;

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<QuranCubit, QuranState>(
        listenWhen: (prev, curr) =>
            curr is QuranSuccess && _pageController == null,
        listener: (context, state) {
          final s = state as QuranSuccess;
          final page = s.stopPage.clamp(1, 604);
          setState(() {
            _pageController = PageController(initialPage: page - 1);
            _displayPage = page;
          });
        },
        builder: (context, state) {
          if (state is! QuranSuccess || _pageController == null) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final cubit = context.read<QuranCubit>();
          final s = state;
          final surahName = cubit.getCurrentSurahName(page: _displayPage);

          return Scaffold(
            backgroundColor: const Color(0xFFF5F0E6),
            appBar: AppBar(
              title: Text(
                surahName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              actions: [
                IconButton(
                  tooltip: 'الأجزاء',
                  icon: const Icon(Icons.view_list_rounded),
                  onPressed: () => _showJuzPicker(context, cubit),
                ),
                IconButton(
                  tooltip: 'السور',
                  icon: const Icon(Icons.menu_book_outlined),
                  onPressed: () => _showSurahPicker(context, s.surahs, cubit),
                ),
              ],
            ),
            body: PageView.builder(
              controller: _pageController,
              itemCount: 604,
              onPageChanged: (index) {
                final page = index + 1;
                final surah = cubit.surahForPage(page);
                setState(() => _displayPage = page);
                cubit.saveReadingPosition(
                  surahId: surah.id,
                  page: page,
                  surahName: surah.name,
                );
              },
              itemBuilder: (context, index) {
                return InteractiveViewer(
                  minScale: 1,
                  maxScale: 4,
                  child: Center(
                    child: Image.asset(
                      cubit.mushafPagePaths[index],
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.high,
                      gaplessPlayback: true,
                      errorBuilder: (_, __, ___) => Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(
                          'تعذر تحميل الصفحة ${arNumber('${index + 1}')}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontFamily: 'Cairo'),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            bottomNavigationBar: Material(
              elevation: 8,
              child: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'صفحة ${arNumber(_displayPage.toString())} من ${arNumber('604')}',
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _showJuzPicker(BuildContext context, QuranCubit cubit) async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) => ListView.builder(
        itemCount: quranAgzaaList.length,
        itemBuilder: (ctx, i) {
          final j = quranAgzaaList[i];
          return ListTile(
            title: Text(j.name, style: const TextStyle(fontFamily: 'Cairo')),
            subtitle: Text(
              'من ${arNumber(j.startPage.toString())} إلى ${arNumber(j.endPage.toString())}',
              style: const TextStyle(fontFamily: 'Cairo', fontSize: 12),
            ),
            onTap: () {
              Navigator.pop(ctx);
              _pageController?.jumpToPage(j.startPage - 1);
              setState(() => _displayPage = j.startPage);
              final surah = cubit.surahForPage(j.startPage);
              cubit.saveReadingPosition(
                surahId: surah.id,
                page: j.startPage,
                surahName: surah.name,
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _showSurahPicker(
    BuildContext context,
    List<SurahModel> surahs,
    QuranCubit cubit,
  ) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (ctx) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.55,
        maxChildSize: 0.92,
        minChildSize: 0.35,
        builder: (ctx, scroll) => ListView.builder(
          controller: scroll,
          itemCount: surahs.length,
          itemBuilder: (ctx, i) {
            final surah = surahs[i];
            return ListTile(
              leading: CircleAvatar(
                child: Text(
                  arNumber('${surah.id}'),
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              title: Text(
                surah.name,
                style: const TextStyle(fontFamily: 'Cairo'),
              ),
              subtitle: Text(
                'صفحة ${arNumber(surah.pageNumber.toString())}',
                style: const TextStyle(fontFamily: 'Cairo', fontSize: 12),
              ),
              onTap: () {
                Navigator.pop(ctx);
                final p = surah.pageNumber.clamp(1, 604);
                _pageController?.jumpToPage(p - 1);
                setState(() => _displayPage = p);
                cubit.saveReadingPosition(
                  surahId: surah.id,
                  page: p,
                  surahName: surah.name,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
