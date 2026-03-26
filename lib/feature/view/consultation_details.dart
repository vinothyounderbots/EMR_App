import 'package:flutter/material.dart';
import 'package:emr_application/core/custom_widgets/custom_text.dart';
import 'package:emr_application/core/custom_widgets/app_button.dart';
import 'package:emr_application/core/extensions/app_extensions.dart';
import 'package:emr_application/config/app_colors.dart';
import 'package:emr_application/config/app_assets.dart';

class ConsultationDetailsScreen extends StatelessWidget {
  const ConsultationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        leading: const BackButton(color: AppColors.black),
        title: const CustomText(
          text: "Consultation details",
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
                color: AppColors.forestGreen,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(AppAssets.iconclock, width: 16, height: 16),
                    const Expanded(
                      child: CustomText(
                        text: "Consultation starts in 10 minutes",
                        color: AppColors.primaryLight,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: Image.asset(
                        AppAssets.icondoctor,
                        width: 64,
                        height: 64,
                        fit: BoxFit.cover,
                      ),
                    ),
                    12.width,
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
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: AppColors.verydarkgrayishblue,
                          ),
                          10.height,
                          GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, '/open_chat'),
                            child: Container(
                              width: 100,
                              decoration: BoxDecoration(
                                color: AppColors.primaryLight,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 6,
                                horizontal: 10,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppAssets.iconchat,
                                    width: 14,
                                    height: 14,
                                    color: Colors.white,
                                  ),
                                  6.width,
                                  const CustomText(
                                    text: "Chat",
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              16.height,
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: "Appointment Details",
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColors.black,
                    ),
                    18.height,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color:
                                AppColors.primaryLight.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(7),
                          child: Image.asset(
                            AppAssets.iconcalendar,
                            width: 22,
                            height: 22,
                            color: AppColors.primaryLight,
                          ),
                        ),
                        12.width,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                text: "Today, March 15, 2024",
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: AppColors.black,
                              ),
                              3.height,
                              const CustomText(
                                text: "2:30 PM - 3:00 PM",
                                color: AppColors.primaryLight,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    18.height,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.greenLight,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(7),
                          child: Image.asset(
                            AppAssets.iconvideocall,
                            width: 22,
                            height: 22,
                            color: AppColors.green,
                          ),
                        ),
                        12.width,
                        Expanded(
                          child: GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, '/zoom_meeting'),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomText(
                                  text: "Online Consultation",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: AppColors.black,
                                ),
                                3.height,
                                const CustomText(
                                  text: "Video call via secure platform",
                                  color: AppColors.verydarkgrayishblue,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    18.height,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.orangeLight,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.all(7),
                          child: Image.asset(
                            AppAssets.iconhash,
                            width: 22,
                            height: 22,
                            color: AppColors.orange,
                          ),
                        ),
                        12.width,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                text: "Booking ID",
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: AppColors.black,
                              ),
                              3.height,
                              const CustomText(
                                text: "APT-2024-0315-001",
                                color: AppColors.verydarkgrayishblue,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              30.height,
              AppButton(
                text: "Join Call",
                height: 48,
                color: AppColors.primaryLight,
                textColor: AppColors.white,
                fontWeight: FontWeight.w400,
                fontSize: 14,
                borderRadius: 50,
                onPressed: () => Navigator.pushNamed(context, '/zoom_meeting'),
              ),
              14.height,
            ],
          ),
        ),
      ),
    );
  }
}
