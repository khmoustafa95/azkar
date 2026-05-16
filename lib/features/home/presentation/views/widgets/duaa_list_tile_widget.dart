import 'package:flutter/material.dart';
import 'package:holly_quran/features/home/data/models/duaa/duaa_model.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/duaa_content_list_tile.dart';

/// List row for a single [DuaaModel] — delegates to [DuaaContentListTile].
class SubDuaaListTileWidget extends StatelessWidget {
  const SubDuaaListTileWidget({
    required this.duaa,
    super.key,
  });

  final DuaaModel duaa;

  @override
  Widget build(BuildContext context) {
    return DuaaContentListTile(
      duaa: duaa,
    );
  }
}
