import 'package:flutter/material.dart';
import 'package:emr_application/config/app_colors.dart';
import 'package:emr_application/config/app_assets.dart';
import 'package:emr_application/core/custom_widgets/custom_text.dart';

import 'package:emr_application/core/extensions/app_extensions.dart';
import 'package:emr_application/feature/view/prescription_records.dart';

class PastConsultationsScreen extends StatefulWidget {
  const PastConsultationsScreen({super.key});

  @override
  State<PastConsultationsScreen> createState() =>
      _PastConsultationsScreenState();
}

class _PastConsultationsScreenState extends State<PastConsultationsScreen> {
  int selectedTab = 1;

  final List<Map<String, String>> pastConsultations = [
    {
      "name": "Dr. Michael Chen",
      "specialty": "Cardiologist",
      "date": "Mar 12 2024, 2:30 PM",
      "type": "Online Consultation",
      "image": AppAssets.icondoctor,
    },
    {
      "name": "Dr. Antony Nicholas",
      "specialty": "Dermatologist",
      "date": "Jan 19 2024, 11:15 AM",
      "type": "In-person Visit",
      "image": AppAssets.icondoctor,
    },
    {
      "name": "Dr. Emily Rodriguez",
      "specialty": "Pediatrician",
      "date": "Jan 19 2024, 11:15 AM",
      "type": "In-person Visit",
      "image": AppAssets.icondoctor,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: pastConsultations.length,
                itemBuilder: (context, index) {
                  final consultation = pastConsultations[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    consultation["image"]!,
                                    width: 48,
                                    height: 48,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                12.width,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: consultation["name"]!,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: AppColors.black,
                                      ),
                                      4.height,
                                      CustomText(
                                        text: consultation["specialty"]!,
                                        fontSize: 13,
                                        color: AppColors.greyDark,
                                      ),
                                      6.height,
                                      Row(
                                        children: [
                                          Image.asset(
                                            AppAssets.iconcalendar,
                                            width: 14,
                                            height: 14,
                                            color: AppColors.greyDark,
                                          ),
                                          6.width,
                                          CustomText(
                                            text: consultation["date"]!,
                                            fontSize: 12,
                                            color: AppColors.greyDark,
                                          ),
                                        ],
                                      ),
                                      6.height,
                                      Row(
                                        children: [
                                          Image.asset(
                                            consultation["type"] ==
                                                    "In-person Visit"
                                                ? AppAssets.iconlocation
                                                : AppAssets.iconvideocall,
                                            width: 14,
                                            height: 14,
                                            color: AppColors.greyDark,
                                          ),
                                          6.width,
                                          CustomText(
                                            text: consultation["type"]!,
                                            fontSize: 13,
                                            color: AppColors.greyDark,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.greyMedium,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const CustomText(
                                    text: "Completed",
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            12.height,
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PrescriptionRecordsScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppColors.greyMedium,
                                    width: 1.2,
                                  ),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                alignment: Alignment.center,
                                child: const CustomText(
                                  text: "Prescription & Records",
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 10),
        child: FloatingActionButton(
          backgroundColor: AppColors.primaryLight,
          onPressed: () {
            Navigator.pushNamed(context, '/booking');
          },
          elevation: 3,
          child: const Icon(
            Icons.add,
            color: AppColors.white,
            size: 24,
          ),
        ),
      ),
    );
  }
}
