import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holly_quran/features/common_widgets/app_bar.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/home/data/models/duaa/duaa_model.dart';
import 'package:holly_quran/features/home/presentation/view_models/duaa/duaa/duaa_cubit.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/duaa_widget.dart';

/// Searchable list of audio duas only (from [DuaaAdiyaHubView]).
class DuaaAudioListView extends StatelessWidget {
  const DuaaAudioListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const AppNavigationBar(
          title: 'أدعية مسموعة',
          backgroundColor: AppNavigationBar.defaultBarGreen,
        ),
        body: BlocBuilder<DuaaCubit, DuaaState>(
          buildWhen: (prev, curr) => prev.runtimeType != curr.runtimeType,
          builder: (context, state) {
            if (state is! DuaaSuccess) {
              return const Center(child: CircularProgressIndicator());
            }
            return _DuaaAudioListBody(allDuaas: state.duaas);
          },
        ),
      ),
    );
  }
}

class _DuaaAudioListBody extends StatefulWidget {
  const _DuaaAudioListBody({required this.allDuaas});

  final List<DuaaModel> allDuaas;

  @override
  State<_DuaaAudioListBody> createState() => _DuaaAudioListBodyState();
}

class _DuaaAudioListBodyState extends State<_DuaaAudioListBody> {
  String _searchQuery = '';

  List<DuaaModel> get _items {
    final q = _searchQuery.trim().toLowerCase();
    return widget.allDuaas
        .where((d) =>
            d.category == DuaaContentCategory.audioDuas &&
            d.type == 'audio' &&
            (q.isEmpty || d.name.toLowerCase().contains(q)))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final items = _items;
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
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
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
