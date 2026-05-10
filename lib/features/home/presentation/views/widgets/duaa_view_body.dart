import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holly_quran/core/extension/extensions.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/common_widgets/state_renderer/state_render.dart';

import '../../../data/models/duaa/duaa_model.dart';
import '../../view_models/duaa/duaa/duaa_cubit.dart';
import 'duaa_widget.dart';

/// One main tab on the duaa / Hajj content screen (order matches [TabController]).
class DuaaMainTabSpec {
  final String category;
  final String label;

  const DuaaMainTabSpec({required this.category, required this.label});
}

/// Main tabs (labels + [DuaaModel.category] keys).
const List<DuaaMainTabSpec> kDuaaMainTabs = [
  DuaaMainTabSpec(
    category: DuaaContentCategory.fiqhHajj,
    label: 'فقه الحج',
  ),
  DuaaMainTabSpec(
    category: DuaaContentCategory.audioDuas,
    label: 'أدعية صوتية',
  ),
  DuaaMainTabSpec(
    category: DuaaContentCategory.fiqhMessages,
    label: 'رسائل فقهية',
  ),
  DuaaMainTabSpec(
    category: DuaaContentCategory.pilgrimAdvice,
    label: 'وصايا الحاج',
  ),
];

class DuaaViewBody extends StatefulWidget {
  const DuaaViewBody({super.key});

  @override
  State<DuaaViewBody> createState() => _DuaaViewBodyState();
}

class _DuaaViewBodyState extends State<DuaaViewBody>
    with SingleTickerProviderStateMixin {
  String _searchQuery = '';
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: kDuaaMainTabs.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<DuaaModel> _itemsForTab(List<DuaaModel> all, int tabIndex) {
    final category = kDuaaMainTabs[tabIndex].category;
    final q = _searchQuery.trim().toLowerCase();
    return all.where((duaa) {
      final matchesSearch =
          q.isEmpty || duaa.name.toLowerCase().contains(q);
      return matchesSearch && duaa.category == category;
    }).toList();
  }

  Widget _buildDuaaList(List<DuaaModel> items) {
    if (items.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(AppPadding.p8),
          child: Text(
            'لا توجد نتائج',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(AppPadding.p8),
      itemCount: items.length,
      itemBuilder: (context, index) => DuaaWidget(duaa: items[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageAssets.background),
          fit: BoxFit.cover,
        ),
      ),
      child: BlocBuilder<DuaaCubit, DuaaState>(
        builder: (context, state) {
          if (state is DuaaSuccess) {
            final all = state.duaas;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'بحث..',
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    for (final t in kDuaaMainTabs) Tab(text: t.label),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      for (var i = 0; i < kDuaaMainTabs.length; i++)
                        _buildDuaaList(_itemsForTab(all, i)),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return StateRender.fullLoadingScreenImage;
          }
        },
      ),
    );
  }
}
