import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:holly_quran/core/extension/extensions.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/card_member.dart';

import 'package:holly_quran/core/resources/app_assets.dart';
import '../../../../../core/resources/app_colors.dart';
import '../../../data/models/duaa/group_model.dart';

class AdminViewBody extends StatefulWidget {
  const AdminViewBody({super.key});

  @override
  State<AdminViewBody> createState() => _AdminViewBodyState();
}

class _AdminViewBodyState extends State<AdminViewBody> {
  int activeIndex = 1;

  @override
  Widget build(BuildContext context) {
    final adminMembers = <MemberModel>[
      MemberModel(
        id: 1,
        name: "محمود رضوان الحداد",
        syPhone: '+963995168816',
        saPhone: '+966542380552',
        trPhone: '+905356055733',
        photo: MemberImageAssets.almasi0,
        position: "رئيس التكتل",
      ),
      MemberModel(
        id: 2,
        name: "خالد علي علبي",
        syPhone: '+963937542401',
        trPhone: '+905350144210',
        photo: MemberImageAssets.almasi2,
        position: "معاون رئيس التكتل",
      ),
      MemberModel(
        id: 3,
        name: "محمود محمد الحجي",
        trPhone: '+905315128572',
        syPhone: '+963980723570',
        photo: MemberImageAssets.almasi4,
        position: "معاون و منسق التكتل",
      ),
      MemberModel(
        id: 4,
        name: "ابراهيم محمد بدران",
        trPhone: '+905395928888',
        syPhone: '+963980376241',
        photo: MemberImageAssets.almasi5,
        position: "منسق التكتل",
      ),
      MemberModel(
        id: 5,
        name: "محمد مصطفى حنوره",
        trPhone: '+905365015580',
        syPhone: '+963945192572',
        photo: MemberImageAssets.almasi5,
        position: "منسق التكتل",
      ),
      MemberModel(
        id: 6,
        name: "أمية عبد المحسن شهاب",
        trPhone: '+905314935812',
        syPhone: '+963996695382',
        photo: MemberImageAssets.almasi8,
        position: "موجهة التكتل",
      ),
      MemberModel(
        id: 7,
        name: "أمل حسن عدس",
        syPhone: '+963999502380',
        photo: MemberImageAssets.almasi8,
        position: "موجهة التكتل",
      ),
      MemberModel(
        id: 8,
        name: "نسرين عبد الرحمن  العلي ",
        trPhone: '+905340405130',
        syPhone: '+963951600652',
        photo: MemberImageAssets.almasi3,
               position: "موجهة التكتل",
      ),
 
    ];
    return Container(
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: AppSize.s1,
            ),

            CarouselSlider.builder(
              itemCount: adminMembers.length,
              itemBuilder: (ctx, index, realIdx) {
                return CardMember(
                    member: adminMembers[index],
                    logo: "assets/images/icon.png");
              },
              options: CarouselOptions(
                initialPage: Random().nextInt(10),
                height: context.height * 0.54,
                viewportFraction: 0.6,
                enableInfiniteScroll: false,
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                autoPlay: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    activeIndex = index;
                  });
                },
              ),
            ),
            const SizedBox(height: AppSize.s16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                adminMembers.length,
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
            // const SizedBox(height: AppSize.s50),
          ],
        ),
      ),
    );
  }
}
