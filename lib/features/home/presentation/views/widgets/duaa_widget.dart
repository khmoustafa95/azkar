import 'package:flutter/material.dart';
import 'package:holly_quran/features/home/data/models/duaa/duaa_model.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/duaa_list_tile_widget.dart';

/// One catalog row in [DuaaCategoryListView].
class DuaaWidget extends StatelessWidget {
  const DuaaWidget({required this.duaa, super.key});

  final DuaaModel duaa;

  @override
  Widget build(BuildContext context) {
    return SubDuaaListTileWidget(duaa: duaa);
  }
}
