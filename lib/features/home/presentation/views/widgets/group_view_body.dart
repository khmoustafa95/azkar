import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:holly_quran/core/extension/extensions.dart';
import 'package:holly_quran/core/resources/values_manager.dart';

import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_routers.dart';
import 'package:holly_quran/core/widgets/group_logo_image.dart';
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
        syPhone: '+963995168816',
        saPhone: '+966542380552',
        trPhone: '+905356055733',
        photo: MemberImageAssets.almasiMahmoudHaddad,
        position: "رئيس التكتل",
      ),
      MemberModel(
        id: 2,
        name: "خالد علي علبي",
        syPhone: '+963937542401',
        trPhone: '+905350144210',
        photo: MemberImageAssets.almasiKhaledOlabi,
        position: "معاون رئيس التكتل",
      ),
      MemberModel(
        id: 3,
        name: "محمود محمد الحجي",
        trPhone: '+905315128572',
        syPhone: '+963980723570',
        photo: MemberImageAssets.almasiMahmoudHajji,
        position: "معاون و منسق التكتل",
      ),
      MemberModel(
        id: 4,
        name: "ابراهيم محمد بدران",
        trPhone: '+905395928888',
        syPhone: '+963980376241',
        photo: MemberImageAssets.almasiIbrahimBadran,
        position: "منسق التكتل",
      ),
      MemberModel(
        id: 5,
        name: "محمد مصطفى حنوره",
        trPhone: '+905365015580',
        syPhone: '+963945192572',
        photo: MemberImageAssets.almasiMohammadHannoura,
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
        photo: MemberImageAssets.almasi8,
        position: "موجهة التكتل",
      ),
    ];
    final enayaMembers = <MemberModel>[
      MemberModel(
        id: 1,
        name: "محمد ياسر أبو كشة",
        trPhone: '+905396739787',
        syPhone: '+963930730472',
        photo: MemberImageAssets.enayaYasserKesheh,
        position: "رئيس المجموعة",
      ),
      MemberModel(
        id: 2,
        name: "محمد نادر احمد محمد",
        trPhone: '+905364921240',
        syPhone: '+963965948665',
        photo: MemberImageAssets.enayaMohammadNader,
        position: "الموجه الديني",
      ),
      MemberModel(
        id: 3,
        name: "محمد عمر العبيد",
        syPhone: '+963938649800',
        photo: MemberImageAssets.enayaMohammadObaid,
        position: "معاون رئيس المجموعة",
      ),
    ];
    final ishraqMembers = <MemberModel>[
      MemberModel(
        id: 1,
        name: "محمد اسماعيل الأحمد",
        trPhone: '+905312386000',
        syPhone: '+963934889063',
        saPhone: '+966567200410',
        photo: MemberImageAssets.ishraqMohammadIsmail,
        position: "رئيس المجموعة",
      ),
      MemberModel(
        id: 2,
        name: "عمار محمد الحاج عمر اليسو",
        syPhone: '+963932484393',
        photo: MemberImageAssets.ishraqAmmarAliso,
        position: "الموجه الديني",
      ),
      MemberModel(
        id: 3,
        name: "محمد وائل أحمد حاج عقيل",
        syPhone: '+963956710463',
        trPhone: '+905370422864',
        photo: MemberImageAssets.ishraqMohammadAkil,
        position: "معاون رئيس المجموعة",
      ),
      MemberModel(
        id: 4,
        name: "علي عبد الهادي العثمان",
        syPhone: '+963984577111',
        photo: MemberImageAssets.ishraqAliOthman,
        position: " مسؤول مكتب سياحي ",
      ),
    ];
    final nemaMembers = <MemberModel>[
      MemberModel(
        id: 1,
        name: "عبد الكريم يحيى البدر",
        trPhone: '+905384884653',
        syPhone: '+963992067542',
        saPhone: '+966507647205',
        photo: MemberImageAssets.nemaaAbdoBadr,
        position: "رئيس المجموعة",
      ),
      MemberModel(
        id: 2,
        name: "مهند الحاج حسن",
        trPhone: '+905387754435',
        syPhone: '+963980639427',
        photo: MemberImageAssets.nemaaMohannadHasan,
        position: "الموجه الديني",
      ),
      MemberModel(
        id: 2,
        name: "محمد علي سمعو درباله",
        trPhone: '++905550017068',
        syPhone: '+963959665814',
        photo: MemberImageAssets.nemaaMohammadDerbala,
        position: "معاون رئيس المجموعة",
      ),
    ];
    final mawasemMembers = <MemberModel>[
      MemberModel(
        id: 1,
        name: "محمد محمود الحجي",
        trPhone: '+905511859843',
        syPhone: '+963983042717',
        photo: MemberImageAssets.mawasemMohammadHajji,
        position: "رئيس المجموعة",
      ),
      MemberModel(
        id: 2,
        name: "عمر محي الدين العبود",
        trPhone: '+905314665000',
        syPhone: '+963992996592',
        photo: MemberImageAssets.mawasemOmarAbboud,
        position: "الموجه الديني",
      ),
      MemberModel(
        id: 3,
        name: "صفا بسام بهلوان",
        syPhone: '+963995244308',
        photo: MemberImageAssets.mawasemSafaBahlwan,
        position: "معاون رئيس المجموعة",
      ),
    ];
    final alnourMembers = <MemberModel>[
      MemberModel(
        id: 1,
        name: "أنس محمد خلف",
        syPhone: '+963943882622',
        photo: MemberImageAssets.alnourAnasKhalaf,
        position: "رئيس المجموعة",
      ),
      MemberModel(
        id: 2,
        name: "عبد الرحمن الشبك",
        syPhone: '+963951603954',
        photo: MemberImageAssets.alnourAbdoulrahmanShabak,
        position: "معاون رئيس المجموعة",
      ),
      MemberModel(
        id: 3,
        name: "أسامة محمد رسول المرعي",
        syPhone: '+963996269332',
        photo: MemberImageAssets.alnourOsamaMouri,
        position: "الموجه الديني",
      ),
      MemberModel(
        id: 4,
        name: "محمد حسين حاج عبود",
        syPhone: '+963937016439',
        photo: MemberImageAssets.alnourMohammadAboud,
        position: "المرشد الديني",
      ),
    ];

    final azaaemMembers = <MemberModel>[
      MemberModel(
        id: 1,
        name: "عبد الرحمن حياني",
        syPhone: '+963997280645',
        photo: MemberImageAssets.azaemAbdulrahmanHayani,
        position: "رئيس المجموعة",
      ),
      MemberModel(
        id: 2,
        name: "عبد الباسط محمد يحيى الزالق",
        trPhone: '+905363424424',
        syPhone: '+963998354647',
        photo: MemberImageAssets.azaemAbdulbasetZaleq,
        position: "الموجه الديني",
      ),
    ];

    final ma3alemMembers = <MemberModel>[
      MemberModel(
        id: 1,
        name: "عبد الرحمن محمد نداف",
        trPhone: '+905347988409',
        syPhone: '+963939656795',
        saPhone: '+966555990754',
        photo: MemberImageAssets.maalemAbdulrahmanNadaf,
        position: "رئيس المجموعة",
      ),
      MemberModel(
        id: 2,
        name: "فاروق عبد اللطيف الصالح",
        syPhone: '+963995597580',
        photo: MemberImageAssets.maalemFaroukSaleh,
        position: "الموجه الديني",
      ),
    ];
    final tahrirMembers = <MemberModel>[
      MemberModel(
        id: 1,
        name: "محمد مصطفى خندقاني",
        syPhone: '+963933999417',
        trPhone: '+90531503006',
        photo: MemberImageAssets.tahrirMohammadKhandakani,
        position: "رئيس المجموعة",
      ),
      MemberModel(
        id: 2,
        name: "حازم وهبي حداد",
        syPhone: '+963987325533',
        photo: MemberImageAssets.tahrirHazemHaddad,
        position: "الموجه الديني",
      ),
    ];
    final shaqrouqMembers = <MemberModel>[
      MemberModel(
        id: 1,
        name: "محمد حسن شقروق",
        syPhone: '+963957507130',
        trPhone: '+905396173467',
        saPhone: '+966541599163',
        photo: MemberImageAssets.shaqrouqMohammadShaqrouq,
        position: "رئيس المجموعة",
      ),
      MemberModel(
        id: 2,
        name: "علي منير علي",
        syPhone: '+963993953974',
        photo: MemberImageAssets.shaqrouqAliAli,
        position: "الموجه الديني",
      ),
    ];
    final waisMembers = <MemberModel>[
      MemberModel(
        id: 1,
        name: "محمد الأمين محمد ويس",
        syPhone: '+963949093909',
        saPhone: '+966564659800',
        photo: MemberImageAssets.waisMohammadWais,
        position: "رئيس المجموعة",
      ),
      MemberModel(
        id: 2,
        name: "عبد الرحمن عبد العزيز عزيزي",
        syPhone: '+963968478643',
        photo: MemberImageAssets.waisAbdulrahmanAzizi,
        position: "المرشد الديني",
      ),
      MemberModel(
        id: 3,
        name: "عبد الحميد جميل محفوظ",
        syPhone: '+963998820102',
        photo: MemberImageAssets.waisAbdulhamidMahfouz,
        position: "معاون رئيس المجموعة",
      ),
      MemberModel(
        id: 2,
        name: "عبد الرحمن محمد خالد دوخة ",
        syPhone: '+963966333252',
        photo: MemberImageAssets.waisAbdulrahmanDoukha,
        position: "معاون رئيس المجموعة",
      ),
    ];
    final haramMembers = <MemberModel>[
      MemberModel(
        id: 1,
        name: "عبد الله ابو النور عدنان الكردي",
        syPhone: '+963965333500',
        photo: MemberImageAssets.haramAbdKurdi,
        position: "رئيس المجموعة",
      ),
      MemberModel(
        id: 2,
        name: "حسام الدين احمد حوت",
        syPhone: '+963935710927',
        photo: MemberImageAssets.haramHussamHout,
        position: "الموجه الديني",
      ),
      MemberModel(
        id: 3,
        name: "عدنان محمد كردي",
        syPhone: '+963933209442',
        photo: MemberImageAssets.haramAdnanKurdi,
        position: "معاون رئيس المجموعة",
      ),
      MemberModel(
        id: 2,
        name: "عبد الكريم يحيى سواس",
        syPhone: '+963951663360',
        photo: MemberImageAssets.haramKarimSawas,
        position: "مسؤول مكتب سياحي",
      ),
    ];
    final groups = <GroupModel>[
      GroupModel(
          id: 0,
          name: "تكتل الماسي",
          logo: GroupSvgAssets.almasi,
          officer: "محمود رضوان الحداد",
          phone: adminMembers.first.syPhone,
          members: adminMembers,
          photo: GroupImageAssets.almasiPhoto),
      GroupModel(
          id: 1,
          name: "مجموعة العناية",
          logo: GroupSvgAssets.enaya,
          officer: "محمد ياسر أبو كشة",
          phone: enayaMembers.first.syPhone,
          members: enayaMembers,
          photo: GroupImageAssets.enayaPhoto),
      GroupModel(
          id: 2,
          name: "مجموعة إشراق",
          logo: GroupSvgAssets.ishraq,
          officer: "محمد اسماعيل الأحمد",
          phone: ishraqMembers.first.syPhone,
          members: ishraqMembers,
          photo: GroupImageAssets.ishraqPhoto),
      GroupModel(
          id: 3,
          name: "مجموعة نماء",
          logo: GroupSvgAssets.nema,
          officer: "عبد الكريم يحيى البدر",
          phone: nemaMembers.first.syPhone,
          members: nemaMembers,
          photo: GroupImageAssets.nemaPhoto),
      GroupModel(
          id: 4,
          name: "مجموعة مواسم",
          logo: GroupSvgAssets.mawasem,
          officer: "محمد محمود الحجي",
          phone: mawasemMembers.first.syPhone,
          members: mawasemMembers,
          photo: GroupImageAssets.mawasemPhoto),
      GroupModel(
          id: 5,
          name: "مجموعة النور",
          logo: GroupSvgAssets.alnour,
          officer: "أنس محمد الخلف",
          phone: alnourMembers.first.syPhone,
          members: alnourMembers,
          photo: GroupImageAssets.alnourPhoto),
      GroupModel(
          id: 6,
          name: "مجموعة عزائم",
          logo: GroupSvgAssets.azaem,
          officer: "عبد الرحمن حياني",
          phone: azaaemMembers.first.syPhone,
          members: azaaemMembers,
          photo: GroupImageAssets.othmanPhoto),
      GroupModel(
          id: 7,
          name: "مجموعة معالم",
          logo: GroupSvgAssets.maalem,
          officer: "عبد الرحمن محمد نداف",
          phone: ma3alemMembers.first.syPhone,
          members: ma3alemMembers,
          photo: GroupImageAssets.tasnimPhoto),
      GroupModel(
          id: 8,
          name: "مجموعة التحرير",
          logo: GroupSvgAssets.tahrir,
          officer: "محمد مصطفى خندقاني",
          phone: tahrirMembers.first.syPhone,
          members: tahrirMembers,
          photo: GroupImageAssets.awnPhoto),
      GroupModel(
          id: 9,
          name: "مجموعة الشقروق",
          logo: GroupSvgAssets.shaqrouq,
          officer: "محمد حسن شقروق",
          phone: shaqrouqMembers.first.syPhone,
          members: shaqrouqMembers,
          photo: GroupImageAssets.rohamaPhoto),
      GroupModel(
          id: 10,
          name: "مجموعة ويس و ملا",
          logo: GroupSvgAssets.wais,
          officer: "محمد الأمين محمد ويس",
          phone: waisMembers.first.syPhone,
          members: waisMembers,
          photo: GroupImageAssets.duraPhoto),
      GroupModel(
          id: 11,
          name: " مجموعة الحرم الشريف",
          logo: GroupSvgAssets.haram,
          officer: "عبد الله ابو النور عدنان الكردي",
          phone: haramMembers.first.syPhone,
          members: haramMembers,
          photo: GroupImageAssets.haramPhoto),
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
            child: GroupLogoImage(
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
