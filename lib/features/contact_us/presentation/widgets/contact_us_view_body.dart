import 'package:flutter/material.dart';
import 'package:holly_quran/core/helper_functions/responsive_layout.dart';
import 'package:holly_quran/core/resources/app_assets.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_constants.dart';
import 'package:holly_quran/core/resources/app_fonts.dart';
import 'package:holly_quran/core/resources/app_strings.dart';
import 'package:holly_quran/core/resources/values_manager.dart';
import 'package:holly_quran/core/widgets/group_logo_image.dart';
import 'package:holly_quran/features/contact_us/presentation/widgets/who_we_are_video.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsViewBody extends StatefulWidget {
  const ContactUsViewBody({super.key});

  @override
  State<ContactUsViewBody> createState() => _ContactUsViewBodyState();
}

class _ContactUsViewBodyState extends State<ContactUsViewBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageAssets.background),
          fit: BoxFit.cover,
        ),
      ),
      child: SingleChildScrollView(
        child: ResponsiveBody(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p4),
          child: Column(
            children: [
            const SizedBox(height: AppSize.s16),
            const WhoWeAreVideo(
              assetPath: VideoAssets.whoWeAre,
              title: 'من نحن؟',
              subtitle: 'تعرّف على تكتل الماسي لخدمات الحج',
            ),
            const SizedBox(height: AppSize.s20),
            const Text(
              AppStrings.contactTitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: FontSize.s17),
            ),
            const SizedBox(height: AppSize.s20),
            const _PartnershipSection(),
            const SizedBox(height: AppSize.s20),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "تابعنا على وسائل التواصل الاجتماعي:",
                style: TextStyle(
                  fontSize: FontSize.s15,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: AppSize.s16),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: AppSize.s20,
              runSpacing: AppSize.s16,
              children: [
                _buildSocialIcon(
                  'واتساب',
                  Icons.chat_rounded,
                  AppConstants.whatsPhone,
                  context,
                  iconColor: const Color(0xFF25D366),
                  isWhatsApp: true,
                ),
                _buildSocialIcon(
                  'فيسبوك',
                  Icons.facebook,
                  'https://www.facebook.com/maasi.hajj',
                  context,
                  iconColor: const Color(0xFF1877F2),
                ),
              ],
            ),
            const SizedBox(height: AppSize.s30),
            ],
          ),
        ),
      ),
    );
  }
}

class _PartnershipSection extends StatelessWidget {
  const _PartnershipSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p14,
        vertical: AppPadding.p16,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(AppSize.s16),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.22),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            AppStrings.contactPartnershipNotice,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: FontConstants.fontFamily,
              fontSize: FontSize.s15,
              fontWeight: FontWeightManager.bold,
              color: AppColors.primary,
              height: 1.45,
            ),
          ),
          const SizedBox(height: AppSize.s16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: _PartnerLogoTile(
                  logoPath: GroupSvgAssets.almasi,
                  label: AppStrings.contactPartnerAlmasi,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p6),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.15),
                        AppColors.primary.withValues(alpha: 0.05),
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.25),
                    ),
                  ),
                  child: Icon(
                    Icons.handshake_rounded,
                    color: AppColors.primary,
                    size: 22,
                  ),
                ),
              ),
              Expanded(
                child: _PartnerLogoTile(
                  logoPath: GroupSvgAssets.mawasem,
                  label: AppStrings.contactPartnerMawasem,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PartnerLogoTile extends StatelessWidget {
  const _PartnerLogoTile({
    required this.logoPath,
    required this.label,
  });

  final String logoPath;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 88,
          height: 88,
          padding: const EdgeInsets.all(AppPadding.p10),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.18),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.12),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: GroupLogoImage(
            logoPath,
            height: 64,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: AppSize.s8),
        Text(
          label,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: FontConstants.fontFamily,
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.semiBold,
            color: const Color(0xFF083A30),
            height: 1.2,
          ),
        ),
      ],
    );
  }
}

Widget _buildSocialIcon(
  String label,
  IconData icon,
  String url,
  BuildContext context, {
  bool isWhatsApp = false,
  Color iconColor = Colors.green,
}) {
  return GestureDetector(
    onTap: () async {
      final launchUrlStr = isWhatsApp ? 'https://wa.me/$url' : url;
      if (await canLaunchUrl(Uri.parse(launchUrlStr))) {
        await launchUrl(Uri.parse(launchUrlStr),
            mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("لا يمكن فتح تطبيق الهاتف على هذا الجهاز")));
        }
      }
    },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
          ),
          child: Icon(icon, color: iconColor, size: 40),
        ),
        const SizedBox(height: 6),
        Text(label, style: TextStyle(fontSize: 13)),
      ],
    ),
  );
}
