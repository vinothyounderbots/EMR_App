import 'package:flutter/material.dart';
import 'package:emr_application/feature/view/prescription_recordss.dart';
import 'package:emr_application/config/app_assets.dart';
import 'package:emr_application/core/extensions/app_extensions.dart';
import 'package:emr_application/core/custom_widgets/custom_text.dart';

import 'package:emr_application/config/app_colors.dart';
import 'package:emr_application/core/custom_widgets/custom_dropdown.dart';

class BulletText extends StatelessWidget {
  final String text;
  const BulletText(this.text, {super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 16)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.verydarkgrayishblue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PrescriptionRecordsScreen extends StatefulWidget {
  const PrescriptionRecordsScreen({super.key});

  @override
  State<PrescriptionRecordsScreen> createState() =>
      _PrescriptionRecordsScreenState();
}

class _PrescriptionRecordsScreenState extends State<PrescriptionRecordsScreen> {
  final TextEditingController _dropdownController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        toolbarHeight: 60,
        leading: const BackButton(color: Colors.black),
        title: const CustomText(
          text: "Prescription & Records",
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.black,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14, top: 8),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.greenLight,
                borderRadius: BorderRadius.circular(18),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              child: const CustomText(
                text: "Confirmed",
                color: AppColors.green,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        AppAssets.icondoctor,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                    ),
                    11.width,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(
                            text: "Dr. Michael Chen",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black,
                          ),
                          const CustomText(
                            text: "Cardiologist",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.verydarkgrayishblue,
                          ),
                          11.height,
                          Row(
                            children: [
                              Image.asset(
                                AppAssets.icontoday,
                                width: 18,
                                height: 18,
                                color: AppColors.greyDark,
                              ),
                              8.width,
                              const Flexible(
                                child: CustomText(
                                  text: "Mar 12 2025, 2:30 PM",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: AppColors.verydarkgrayishblue,
                                ),
                              ),
                            ],
                          ),
                          7.height,
                          Row(
                            children: [
                              Image.asset(
                                AppAssets.iconvideocall,
                                width: 18,
                                height: 18,
                                color: AppColors.greyDark,
                              ),
                              8.width,
                              const Flexible(
                                child: CustomText(
                                  text: "Online Consultation",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: AppColors.verydarkgrayishblue,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              14.height,
              Container(
                padding: const EdgeInsets.fromLTRB(15, 16, 15, 15),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: "Doctor's Notes",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                    8.height,
                    const CustomText(
                      text:
                          "Patient shows improvement in blood pressure. Continue current medication. Schedule follow-up in 4 weeks.",
                      fontSize: 14,
                      color: AppColors.verydarkgrayishblue,
                      fontWeight: FontWeight.w400,
                    ),
                    13.height,
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(
                            text: "Prescription Summary",
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: AppColors.black,
                          ),
                          8.height,
                          const CustomText(
                            text: "Antihistamines",
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: AppColors.black,
                          ),
                          const CustomText(
                            text: "5ml | Morning | Empty stomach (30 d)",
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: AppColors.verydarkgrayishblue,
                          ),
                          6.height,
                          const CustomText(
                            text: "Leukotriene receptor antagonists",
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: AppColors.black,
                          ),
                          const CustomText(
                            text:
                                "+1 | Morning, Afternoon, Evening | After meals (90 d)",
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: AppColors.verydarkgrayishblue,
                          ),
                        ],
                      ),
                    ),
                    13.height,
                    const CustomText(
                      text: "Attachments",
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColors.black,
                    ),
                    7.height,
                    Wrap(
                      spacing: 8,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.background,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                AppAssets.iconpdf,
                                width: 15,
                                height: 15,
                                color: AppColors.primary,
                              ),
                              5.width,
                              const CustomText(
                                text: "ECG Report",
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.primaryLight,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColors.greenLight,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                AppAssets.iconlabresults,
                                width: 15,
                                height: 15,
                                color: AppColors.green,
                              ),
                              5.width,
                              const CustomText(
                                text: "Lab Results",
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.green,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              14.height,
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: "Discharge Instructions",
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColors.black,
                    ),
                    8.height,
                    const BulletText(
                        "Take prescribed medicines regularly and monitor blood pressure twice daily."),
                    const BulletText(
                        "Avoid heavy physical exertion for the next few days."),
                    const BulletText(
                        "Follow a low-sodium diet and stay hydrated."),
                    const BulletText(
                        "Visit the clinic immediately if you experience chest pain or dizziness."),
                    13.height,
                    const CustomText(
                      text: "Education Notes",
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColors.black,
                    ),
                    8.height,
                    const BulletText(
                        "Learn about healthy lifestyle habits that support heart health – include more fruits, vegetables, and fiber in your meals."),
                    const BulletText(
                        "Avoid smoking, reduce caffeine, and practice deep breathing or relaxation exercises."),
                    const BulletText(
                        "Maintain a daily log of your blood pressure readings to share at your next appointment."),
                    // 13.height,
                    // const CustomText(
                    //   text: "Patient Acknowledgement",
                    //   fontWeight: FontWeight.w400,
                    //   fontSize: 16,
                    //   color: AppColors.black,
                    // ),
                    // 8.height,
                    // CustomCupertinoDropdownField(
                    //   controller: _dropdownController,
                    //   hint: 'select your understanding level',
                    // ),
                    // 14.height,
                    // Container(
                    //   width: double.infinity,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(8),
                    //     color: const Color.fromARGB(255, 81, 168, 255),
                    //   ),
                    //   child: TextButton(
                    //     onPressed: () {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) =>
                    //               const PrescriptionRecordScreen(),
                    //         ),
                    //       );
                    //     },
                    //     child: const CustomText(
                    //       text: 'Submit Acknowledgement',
                    //       size: 16,
                    //       weight: FontWeight.w400,
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              20.height,
            ],
          ),
        ),
      ),
    );
  }
}
