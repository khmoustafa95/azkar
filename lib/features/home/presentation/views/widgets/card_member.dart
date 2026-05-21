import 'package:flutter/material.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/core/widgets/group_logo_image.dart';
import 'package:holly_quran/features/home/data/models/duaa/group_model.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/phone_widget.dart';

class CardMember extends StatelessWidget {
  const CardMember({super.key, required this.member, required this.logo});
  final MemberModel member;
  final String logo;

  List<Color> getColorsFromValue(int value) {
    value = value.clamp(1, 10);
    double t = (value - 1) / 9;

    // Define key gradient stops
    final colorStops = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.purple,
      Colors.white,
      Colors.grey,
      Colors.greenAccent,
      Colors.amber,
      Colors.black26,
      Colors.blueAccent,
    ];

    // Map `t` (0..1) to a segment between two color stops
    int segmentCount = colorStops.length - 1;
    double scaledT = t * segmentCount;
    int index = scaledT.floor();
    double localT = scaledT - index;

    // Avoid overflow on last index
    if (index >= segmentCount) {
      index = segmentCount - 1;
      localT = 1.0;
    }

    Color from = colorStops[index];
    Color to = colorStops[index + 1];

    // Interpolate main gradient color
    Color start = Color.lerp(from, to, localT)!;

    // Optionally create slight variation for gradient effect
    Color end = Color.lerp(from, to, (localT + 0.2).clamp(0.0, 1.0))!;

    return [start, end];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: AppMargin.m8),
      width: double.infinity * 0.8,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s20),
        color: AppColors.white,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: AppSize.s100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: getColorsFromValue(member.id),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  left: 0,
                  top: AppSize.s20,
                  child: CircleAvatar(
                    radius: AppSize.s70,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: AppSize.s60,
                      backgroundImage: AssetImage(member.photo),
                    ),
                  ),
                ),
              ],
            ),
            // Profile Image with spacing
            // Transform.translate(
            //   offset: const Offset(0, -AppSize.s80),
            //   child: CircleAvatar(
            //     radius: AppSize.s70,
            //     backgroundColor: Colors.white,
            //     child: CircleAvatar(
            //       radius: AppSize.s60,
            //       backgroundImage: AssetImage(group.photo),
            //     ),
            //   ),
            // ),
            SizedBox(height: AppSize.s60),

            Container(
              color: const Color(0xFF1E2D5C), // Blue background
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                member.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                member.position,
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
              child: GroupLogoImage(logo, height: AppSize.s80),
            ),

            // Phone Number
            PhoneWidget(
              phone: member.syPhone,
              saPhone: member.saPhone,
              // trPhone: member.trPhone,
            ),
          ],
        ),
      ),
    );
  }
}
