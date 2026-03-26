import 'package:flutter/material.dart';
import 'package:emr_application/config/app_colors.dart';
import 'package:emr_application/core/custom_widgets/custom_text.dart';

class ConsultationCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String statusText;
  final Color statusColor;
  final Color statusTextColor;
  final List<Widget> icons;
  final List<Widget> buttons;
  final String doctorImage;

  const ConsultationCard({
    super.key,
    required this.name,
    required this.specialty,
    required this.statusText,
    required this.statusColor,
    required this.statusTextColor,
    required this.icons,
    required this.buttons,
    required this.doctorImage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16, top: 8),
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
        // decoration: BoxDecoration(
        //   color: AppColors.white,
        //   borderRadius: BorderRadius.circular(18),
        //   boxShadow: [
        //     BoxShadow(
        //       color: Colors.grey.shade100,
        //       blurRadius: 16,
        //       spreadRadius: 1,
        //       offset: const Offset(0, 3),
        //     ),
        //   ],
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    doctorImage,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 48,
                        height: 48,
                        color: AppColors.blueLight,
                        child: const Icon(Icons.person, color: AppColors.primary),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: name,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                      CustomText(
                        text: specialty,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyDark,
                      ),
                      const SizedBox(height: 2),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 2),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: CustomText(
                    text: statusText,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: statusTextColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...icons,
            const SizedBox(height: 11),
            Row(
              children: buttons
                  .map(
                    (b) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: b,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
