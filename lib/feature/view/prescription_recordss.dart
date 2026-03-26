import 'package:flutter/material.dart';
import 'package:emr_application/config/app_assets.dart';
import 'package:emr_application/core/extensions/app_extensions.dart';
import 'package:emr_application/core/custom_widgets/custom_text.dart';
import 'package:emr_application/config/app_colors.dart';

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

class PrescriptionRecordScreen extends StatefulWidget {
  const PrescriptionRecordScreen({super.key});

  @override
  State<PrescriptionRecordScreen> createState() =>
      _PrescriptionRecordScreenState();
}

class _PrescriptionRecordScreenState extends State<PrescriptionRecordScreen> {
  // Mock data for display
  final Map<String, dynamic> _doctorInfo = {
    'name': "Dr. Michael Chen",
    'specialty': "Cardiologist",
    'time': "Mar 12 2025, 2:30 PM",
    'type': "Online Consultation",
  };

  final String _doctorNotes =
      "Patient shows improvement in blood pressure. Continue current medication. Schedule follow-up in 4 weeks.";

  final List<String> _dischargeInstructions = [
    "Take prescribed medicines regularly and monitor blood pressure twice daily.",
    "Avoid heavy physical exertion for the next few days.",
    "Follow a low-sodium diet and stay hydrated.",
    "Visit the clinic immediately if you experience chest pain or dizziness.",
  ];

  final List<String> _educationNotes = [
    "Learn about healthy lifestyle habits that support heart health – include more fruits, vegetables, and fiber in your meals.",
    "Avoid smoking, reduce caffeine, and practice deep breathing or relaxation exercises.",
    "Maintain a daily log of your blood pressure readings to share at your next appointment.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDoctorHeader(),
              14.height,
              _buildNotesSection(),
              14.height,
              _buildInstructionsSection(),
              20.height,
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.white,
      toolbarHeight: 60,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
      ),
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
    );
  }

  Widget _buildDoctorHeader() {
    return Container(
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
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: _doctorInfo['name'],
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                ),
                CustomText(
                  text: _doctorInfo['specialty'],
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.verydarkgrayishblue,
                ),
                11.height,
                Row(
                  children: [
                    Image.asset(
                      AppAssets.iconcalendar2,
                      width: 18,
                      height: 18,
                      color: AppColors.greyDark,
                    ),
                    8.width,
                    Flexible(
                      child: CustomText(
                        text: _doctorInfo['time'],
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
                    Flexible(
                      child: CustomText(
                        text: _doctorInfo['type'],
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
    );
  }

  Widget _buildNotesSection() {
    return Container(
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
          CustomText(
            text: _doctorNotes,
            fontSize: 14,
            color: AppColors.verydarkgrayishblue,
            fontWeight: FontWeight.w400,
          ),
          13.height,
          _buildPrescriptionSummary(),
          13.height,
          _buildAttachments(),
        ],
      ),
    );
  }

  Widget _buildPrescriptionSummary() {
    return Container(
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
            text: "+1 | Morning, Afternoon, Evening | After meals (90 d)",
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: AppColors.verydarkgrayishblue,
          ),
        ],
      ),
    );
  }

  Widget _buildAttachments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            _buildAttachmentChip(
                "ECG Report", AppAssets.iconpdf, AppColors.primaryLight),
            _buildAttachmentChip(
                "Lab Results", AppAssets.iconlabresults, AppColors.green),
          ],
        ),
      ],
    );
  }

  Widget _buildAttachmentChip(String label, String icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color == AppColors.green
            ? AppColors.greenLight
            : AppColors.background,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            icon,
            width: 15,
            height: 15,
            color: color,
          ),
          5.width,
          CustomText(
            text: label,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionsSection() {
    return Container(
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
          ..._dischargeInstructions.map((text) => BulletText(text)),
          13.height,
          const CustomText(
            text: "Education Notes",
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: AppColors.black,
          ),
          8.height,
          ..._educationNotes.map((text) => BulletText(text)),
        ],
      ),
    );
  }
}
