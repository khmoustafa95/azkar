import 'package:flutter/material.dart';
import 'package:holly_quran/core/extension/extensions.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/core/widgets/app_page_carousel.dart';
import 'package:holly_quran/features/common_widgets/app_bar.dart';
import 'package:holly_quran/features/home/data/models/duaa/group_model.dart';

import '../../../../../core/resources/app_assets.dart';
import '../../../../../core/resources/app_colors.dart';
import 'card_member.dart';

class GroupDetailsView extends StatefulWidget {
  final GroupModel group;
  final String id;

  const GroupDetailsView({super.key, required this.group, required this.id});

  @override
  State<GroupDetailsView> createState() => _GroupDetailsViewState();
}

class _GroupDetailsViewState extends State<GroupDetailsView> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppNavigationBar(title: widget.group.name),
        body: Container(
          height: context.height,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageAssets.background),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: AppSize.s1),
                if (widget.group.members.isNotEmpty) ...[
                  AppPageCarousel(
                    itemCount: widget.group.members.length,
                    height: context.height * 0.65,
                    viewportFraction: 0.6,
                    autoPlay: true,
                    onPageChanged: (index) => setState(() => activeIndex = index),
                    itemBuilder: (ctx, index) {
                      return CardMember(
                        member: widget.group.members[index],
                        logo: widget.group.logo,
                      );
                    },
                  ),
                  const SizedBox(height: AppSize.s16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      widget.group.members.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: activeIndex == index
                              ? AppColors.primary
                              : Colors.grey[400],
                        ),
                      ),
                    ),
                  ),
                ],
                if (widget.group.members.isEmpty)
                  Column(
                    children: [
                      SizedBox(height: context.height * 0.4),
                      const Center(
                        child: Text('لا يوجد اعضاء في هذه المجموعة'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
