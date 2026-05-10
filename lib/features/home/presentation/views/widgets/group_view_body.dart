import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:holly_quran/core/extension/extensions.dart';
import 'package:holly_quran/core/resources/values_manager.dart';

import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_routers.dart';
import '../../../data/models/duaa/group_model.dart';
import 'card_group.dart';

class GroupViewBody extends StatefulWidget {
  const GroupViewBody({super.key});

  @override
  State<GroupViewBody> createState() => _GroupViewBodyState();
}

class _GroupViewBodyState extends State<GroupViewBody> {
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

    final othmanMembers = <MemberModel>[
      MemberModel(
        id: 1,
        name: "عثمان خان سليمان",
        phone: '+905392008784',
        photo: MemberImageAssets.othman1,
        position: "رئيس المجموعة",
      ),
      MemberModel(
        id: 2,
        name: "علاء محمد نداف",
        phone: '+905394007007',
        photo: MemberImageAssets.othman2,
        position: "معاون رئيس المجموعة",
      ),
      MemberModel(
        id: 3,
        name: "أحمد علي ياسين",
        phone: '+905541585000',
        photo: MemberImageAssets.othman3,
        position: "الموجه الديني",
      ),
    ];
    final tasnimMembers = <MemberModel>[
      MemberModel(
        id: 1,
        name: "محمد أحمد أحمد",
        phone: '+905374545063',
        photo: MemberImageAssets.tasnim1,
        position: "رئيس المجموعة",
      ),
      MemberModel(
        id: 2,
        name: "مروان حسن عبدو",
        phone: '+905385294113',
        photo: MemberImageAssets.tasnim2,
        position: "معاون رئيس المجموعة",
      ),
      MemberModel(
        id: 3,
        name: "فاروق عبد اللطيف الصالح",
        phone: '+905366993171',
        photo: MemberImageAssets.tasnim3,
        position: "الموجه الديني",
      ),
    ];
    final alnourMembers = <MemberModel>[
      MemberModel(
        id: 1,
        name: "أنس محمد خلف",
        phone: '+963982471753',
        photo: MemberImageAssets.alnour1,
        position: "رئيس المجموعة",
      ),
      MemberModel(
        id: 2,
        name: "عبد الرحمن الشبك",
        phone: '+905372930089',
        photo: MemberImageAssets.alnour2,
        position: "معاون رئيس المجموعة",
      ),
      MemberModel(
        id: 3,
        name: "أسامة محمد رسول المرعي",
        phone: '+905349272277',
        photo: MemberImageAssets.alnour3,
        position: "الموجه الديني",
      ),
    ];
    final rohamaMembers = <MemberModel>[
      MemberModel(
        id: 1,
        name: "محمود العلي العلي الموسى",
        phone: '+905392714207',
        photo: MemberImageAssets.rohama1,
        position: "رئيس المجموعة",
      ),
      MemberModel(
        id: 2,
        name: "طه محمد ربيع جبان",
        phone: '+905357298078',
        photo: MemberImageAssets.rohama2,
        position: "معاون رئيس المجموعة",
      ),
      MemberModel(
        id: 3,
        name: "عمر محمد وليد العمر",
        phone: '+905377973900',
        photo: MemberImageAssets.rohama3,
        position: "الموجه الديني",
      ),
    ];
    final awnMembers = <MemberModel>[
      MemberModel(
        id: 1,
        name: "عبيد حميدي العبيد",
        phone: '+963999502380',
        photo: MemberImageAssets.awn1,
        position: "رئيس المجموعة",
      ),
      MemberModel(
        id: 2,
        name: " عبد المولى أحمد البكوري",
        phone: '+963932751764',
        photo: MemberImageAssets.awn2,
        position: "معاون رئيس المجموعة",
      ),
      MemberModel(
        id: 3,
        name: "محمد صادق المصطاوي",
        phone: '+963999502380',
        photo: MemberImageAssets.awn3,
        position: "الموجه الديني",
      ),
    ];
    final duraMembers = <MemberModel>[
      MemberModel(
        id: 1,
        name: "أجمد شيخو شيخو",
        phone: '+963937585189',
        photo: MemberImageAssets.dura1,
        position: "رئيس المجموعة",
      ),
      MemberModel(
        id: 2,
        name: "حسني معاوية الدبك",
        phone: '+905394007875',
        photo: MemberImageAssets.dura2,
        position: "الموجه الديني",
      ),
    ];
    final enayaMembers = <MemberModel>[
      MemberModel(
        id: 1,
        name: "محمد ياسر أبو كشة",
        phone: '+905396739787',
        photo: MemberImageAssets.enaya1,
        position: "رئيس المجموعة",
      ),
      MemberModel(
        id: 2,
        name: "محمد نادر محمد",
        phone: '+905394007875',
        photo: MemberImageAssets.enaya2,
        position: "الموجه الديني",
      ),
    ];
    final nemaMembers = <MemberModel>[
      MemberModel(
        id: 1,
        name: "عبد الكريم يحيى البدر",
        phone: '+905384884653',
        photo: MemberImageAssets.nema1,
        position: "رئيس المجموعة",
      ),
      MemberModel(
        id: 2,
        name: "مهند الحاج حسن",
        phone: '+905387754435',
        photo: MemberImageAssets.nema2,
        position: "الموجه الديني",
      ),
    ];
    final ishraqMembers = <MemberModel>[
      MemberModel(
        id: 1,
        name: "محمد اسماعيل الأحمد",
        phone: '+905312386000',
        photo: MemberImageAssets.ishraq1,
        position: "رئيس المجموعة",
      ),
      MemberModel(
        id: 2,
        name: "عمار بسام اليسو",
        phone: '+963932484393',
        photo: MemberImageAssets.ishraq2,
        position: "الموجه الديني",
      ),
    ];
    final mawasemMembers = <MemberModel>[
      MemberModel(
        id: 1,
        name: "محمد محمود الحجي",
        phone: '+905511859843',
        photo: MemberImageAssets.mawasem1,
        position: "رئيس المجموعة",
      ),
      MemberModel(
        id: 2,
        name: "عمر محي الدين العبود",
        phone: '+905314665000',
        photo: MemberImageAssets.mawasem2,
        position: "الموجه الديني",
      ),
    ];
    final groups = <GroupModel>[
      GroupModel(
          id: 0,
          name: "تكتل الماسي",
          logo: GroupImageAssets.almasiLogo,
          officer: "محمود رضوان الحداد",
          phone: '+905392008784',
          members: adminMembers,
          photo: GroupImageAssets.almasiPhoto),
      GroupModel(
          id: 1,
          name: "مجموعة عثمان بن عفان",
          logo: GroupImageAssets.othmanLogo,
          officer: "عثمان خان سليمان",
          phone: '+905392008784',
          members: othmanMembers,
          photo: GroupImageAssets.othmanPhoto),
      GroupModel(
          id: 2,
          name: "مجموعة تسنيم",
          logo: GroupImageAssets.tasnimLogo,
          officer: "محمد أحمد أحمد",
          phone: '+905375455063',
          members: tasnimMembers,
          photo: GroupImageAssets.tasnimPhoto),
      GroupModel(
          id: 3,
          name: "مجموعة عون الحاج",
          logo: GroupImageAssets.awnLogo,
          officer: "عبيد حميدي العبيد",
          phone: '+963999502380',
          members: awnMembers,
          photo: GroupImageAssets.awnPhoto),
      GroupModel(
          id: 4,
          name: "مجموعة النور",
          logo: GroupImageAssets.alnourLogo,
          officer: "أنس محمد الخلف",
          phone: '+963982471753',
          members: alnourMembers,
          photo: GroupImageAssets.alnourPhoto),
      GroupModel(
          id: 5,
          name: "مجموعة الرحماء",
          logo: GroupImageAssets.rohamaLogo,
          officer: "محمود علي الموسى",
          phone: '+905392714207',
          members: rohamaMembers,
          photo: GroupImageAssets.rohamaPhoto),
      GroupModel(
          id: 6,
          name: "مجموعة نماء",
          logo: GroupImageAssets.nemaLogo,
          officer: "عبد الكريم يحيى البدر",
          phone: '+905384884653',
          members: nemaMembers,
          photo: GroupImageAssets.nemaPhoto),
      GroupModel(
          id: 7,
          name: "مجموعة مواسم",
          logo: GroupImageAssets.mawasemLogo,
          officer: "محمد محمود الحجي",
          phone: '+905511859843',
          members: mawasemMembers,
          photo: GroupImageAssets.mawasemPhoto),
      GroupModel(
          id: 8,
          name: "مجموعة العناية",
          logo: GroupImageAssets.enayaLogo,
          officer: "محمد ياسر أبو كشة",
          phone: '+905396739787',
          members: enayaMembers,
          photo: GroupImageAssets.enayaPhoto),
      GroupModel(
          id: 9,
          name: "مجموعة درة الماشي",
          logo: GroupImageAssets.duraLogo,
          officer: "أحمد شيخو شيخو",
          phone: '+963937585189',
          members: duraMembers,
          photo: GroupImageAssets.duraPhoto),
      GroupModel(
          id: 10,
          name: "مجموعة إشراق",
          logo: GroupImageAssets.ishraqLogo,
          officer: "محمد اسماعيل الأحمد",
          phone: '+905312386000',
          members: ishraqMembers,
          photo: GroupImageAssets.ishraqPhoto),
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
              itemCount: groups.length,
              itemBuilder: (ctx, index, realIdx) {
                return CardGroup(
                    group: groups[index],
                    onTap: () => GoRouter.of(context).pushNamed(
                          Routes.groupDetailsRoute,
                          pathParameters: {
                            'id1': '${groups[index].id}',
                          },
                          extra: groups[index].toJson(),
                        ));
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
                groups.length,
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

Card buildContainerScreen(GroupModel groupModel) {
  return Card(
    margin: EdgeInsets.all(AppSize.s8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    elevation: 4,
    child: Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.asset(
              groupModel.photo,
              width: 75,
              height: 75,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),

          // Name
          Container(
            color: const Color(0xFF1E2D5C), // Blue background
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              groupModel.officer,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Subtitle
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              groupModel.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Logo
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Image.asset(
              groupModel.logo,
              height: 60,
            ),
          ),

          // Phone Number
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              groupModel.phone,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
