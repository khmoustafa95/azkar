import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holly_quran/features/common_widgets/app_bar.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/home/data/models/duaa/duaa_model.dart';
import 'package:holly_quran/features/home/presentation/view_models/duaa/duaa/duaa_cubit.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/duaa_video_grid_view.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/duaa_widget.dart';

/// Lists content for one [DuaaContentCategory] (videos in grid, legacy list otherwise).
class DuaaCategoryListView extends StatelessWidget {
  const DuaaCategoryListView({
    super.key,
    required this.category,
    required this.title,
  });

  final String category;
  final String title;

  static bool usesVideoGrid(String category) =>
      category == DuaaContentCategory.fiqhHajj ||
      category == DuaaContentCategory.fiqhMessages ||
      category == DuaaContentCategory.pilgrimAdvice;

  @override
  Widget build(BuildContext context) {
    final isVideoGrid = usesVideoGrid(category);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppNavigationBar(
          title: title,
          backgroundColor: AppNavigationBar.defaultBarGreen,
        ),
        body: BlocBuilder<DuaaCubit, DuaaState>(
          buildWhen: (prev, curr) => prev.runtimeType != curr.runtimeType,
          builder: (context, state) {
            if (state is! DuaaSuccess) {
              return const Center(child: CircularProgressIndicator());
            }
            return _DuaaCategoryBody(
              category: category,
              isVideoGrid: isVideoGrid,
              allDuaas: state.duaas,
            );
          },
        ),
      ),
    );
  }
}

class _DuaaCategoryBody extends StatefulWidget {
  const _DuaaCategoryBody({
    required this.category,
    required this.isVideoGrid,
    required this.allDuaas,
  });

  final String category;
  final bool isVideoGrid;
  final List<DuaaModel> allDuaas;

  @override
  State<_DuaaCategoryBody> createState() => _DuaaCategoryBodyState();
}

class _DuaaCategoryBodyState extends State<_DuaaCategoryBody> {
  String _searchQuery = '';

  List<DuaaModel> get _items {
    final q = _searchQuery.trim().toLowerCase();
    return widget.allDuaas.where((duaa) {
      final matchesSearch =
          q.isEmpty || duaa.name.toLowerCase().contains(q);
      final matchesCategory = duaa.category == widget.category;
      final matchesType =
          widget.isVideoGrid ? duaa.type == 'video' : true;
      return matchesSearch && matchesCategory && matchesType;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final items = _items;

    if (widget.isVideoGrid) {
      return DuaaVideoGridView(
        items: items,
        searchQuery: _searchQuery,
        onSearchChanged: (v) => setState(() => _searchQuery = v),
      );
    }

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
            onChanged: (v) => setState(() => _searchQuery = v),
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
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo',
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(
                    AppPadding.p12,
                    0,
                    AppPadding.p12,
                    AppPadding.p20,
                  ),
                  itemCount: items.length,
                  itemBuilder: (_, i) => DuaaWidget(duaa: items[i]),
                ),
        ),
      ],
    );
  }
}
