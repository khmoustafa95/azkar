import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:holly_quran/core/extension/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/resources/values_manager.dart';

class PhoneWidget extends StatelessWidget {
  const PhoneWidget({super.key, required this.phone, this.saPhone});
  final String phone;
  final String? saPhone;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSize.s16),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: AppSize.s8),
            child: Text(
              "SY: ${phone.toFormattedPhone()}",
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () async {
                      final url = 'https://wa.me/$phone';
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  "لا يمكن فتح تطبيق الهاتف على هذا الجهاز")),
                        );
                        // Optional: Show error message
                        print("Cannot launch whatsapp");
                      }
                    },
                    child: const Icon(FontAwesomeIcons.whatsapp,
                        color: Colors.green, size: 24),
                  ),
                  Text(
                    "مراسلة",
                    style: TextStyle(fontSize: 10),
                  )
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () async {
                      final uri = Uri.parse('tel:$phone');
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri, mode: LaunchMode.platformDefault);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  "لا يمكن فتح تطبيق الهاتف على هذا الجهاز")),
                        );
                        // Optional: Show error message
                        print("Cannot launch dialer");
                      }
                    },
                    child: const Icon(Icons.call_outlined,
                        color: Colors.green, size: 24),
                  ),
                  Text(
                    "اتصال",
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              )
            ],
          ),
          if (saPhone != null) ...[
            Divider(
              color: Colors.grey,
              thickness: 1,
              endIndent: context.width * 0.05,
              indent: context.width * 0.05,
            ),
            Container(
              margin: EdgeInsets.only(bottom: AppSize.s8),
              child: Text(
                "SA: ${saPhone!.toFormattedPhone()}",
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        final url = 'https://wa.me/$saPhone';
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(Uri.parse(url));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    "لا يمكن فتح تطبيق الهاتف على هذا الجهاز")),
                          );
                          // Optional: Show error message
                          print("Cannot launch whatsapp");
                        }
                      },
                      child: const Icon(FontAwesomeIcons.whatsapp,
                          color: Colors.green, size: 24),
                    ),
                    Text(
                      "مراسلة",
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        final uri = Uri.parse('tel:$saPhone');
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri,
                              mode: LaunchMode.platformDefault);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    "لا يمكن فتح تطبيق الهاتف على هذا الجهاز")),
                          );
                          // Optional: Show error message
                          print("Cannot launch dialer");
                        }
                      },
                      child: const Icon(Icons.call_outlined,
                          color: Colors.green, size: 24),
                    ),
                    Text(
                      "اتصال",
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                )
              ],
            ),
          ]
        ],
      ),
    );
  }
}
