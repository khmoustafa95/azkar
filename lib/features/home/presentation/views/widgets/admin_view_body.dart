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
        phone: '+905356055733',
        photo: MemberImageAssets.almasi0,
        position: "رئيس التكتل",
      ),
      MemberModel(
        id: 2,
        name: "عبد الرحمن حياني",
        phone: '+905380777027',
        photo: MemberImageAssets.almasi1,
        position: "معاون رئيس التكتل",
      ),
      MemberModel(
        id: 3,
        name: "خالد علي علبي",
        phone: '+905350144210',
        photo: MemberImageAssets.almasi2,
        position: "معاون رئيس التكتل",
      ),
      MemberModel(
        id: 4,
        name: "موسى محمد الإبراهيم",
        phone: '+905374725875',
        photo: MemberImageAssets.almasi3,
        position: "المرشد الديني للتكتل",
      ),
      MemberModel(
        id: 5,
        name: "محمود محمد الحجي",
        phone: '+905315128572',
        photo: MemberImageAssets.almasi4,
        position: "معاون و منسق التكتل",
      ),
      MemberModel(
        id: 6,
        name: "ابراهيم محمد بدران",
        phone: '+905395928888',
        photo: MemberImageAssets.almasi5,
        position: "منسق التكتل",
      ),
      MemberModel(
        id: 7,
        name: "رياض حسين طيفور",
        phone: '+905537858568',
        photo: MemberImageAssets.almasi6,
        position: "منسق التكتل",
      ),
      MemberModel(
        id: 8,
        name: "محمد محمد رياض ضبيط",
        phone: '+963968152939',
        photo: MemberImageAssets.almasi7,
        position: "منسق التكتل",
      ),
      MemberModel(
        id: 9,
        name: "أمية عبد المحسن شهاب",
        phone: '+905314935812',
        photo: MemberImageAssets.almasi8,
        position: "موجهة التكتل",
      ),
      MemberModel(
        id: 10,
        name: "أمل حسن عدس",
        phone: '+905317262999',
        photo: MemberImageAssets.almasi8,
        position: "موجهة التكتل",
      ),
      MemberModel(
        id: 11,
        name: "أمل أحمد محمد هادي",
        phone: '+905523248735',
        photo: MemberImageAssets.almasi8,
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
