import 'package:flutter/material.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/core/widgets/group_logo_image.dart';
import 'package:holly_quran/features/home/data/models/duaa/group_model.dart';
import 'package:holly_quran/features/home/presentation/views/widgets/phone_widget.dart';

class CardGroup extends StatelessWidget {
  const CardGroup({
    super.key,
    required this.group,
    required this.onTap,
    this.saPhone,
  });
  final GroupModel group;
  final String? saPhone;
  final void Function() onTap;

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
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: AppMargin.m8),
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
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
                        colors: getColorsFromValue(group.id),
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
                        backgroundImage: AssetImage(group.photo),
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
                  group.officer,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  group.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              // Logo
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: GroupLogoImage(group.logo, height: AppSize.s80),
              ),

              // Phone Number
              PhoneWidget(phone: group.phone, saPhone: group.saPhone),
            ],
          ),
        ),
      ),
    );
  }
}
