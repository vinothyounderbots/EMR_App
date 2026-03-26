import 'package:flutter/material.dart';
import 'package:emr_application/config/app_colors.dart';
import 'package:emr_application/config/app_assets.dart';
import 'package:emr_application/core/custom_widgets/custom_text.dart';
import 'package:emr_application/core/extensions/app_extensions.dart';

class MedicationScreen extends StatefulWidget {
  const MedicationScreen({super.key});

  @override
  State<MedicationScreen> createState() => _MedicationScreenState();
}

class _MedicationScreenState extends State<MedicationScreen> {
  int _selectedTab = 0;

  // Mock data for medications.
  final List<Map<String, dynamic>> _currentMedications = [
    {
      'iconBg': AppColors.purpleLight,
      'iconAsset': AppAssets.icontablet,
      'medName': "Antihistamines",
      'medType': "Syrup",
      'medInfo': "5ml | Morning | Empty stomach",
      'duration': "Duration: 90 days (until Jan 15, 2025)",
      'prescribed': "Prescribed by Dr. Sarah Johnson",
    },
    {
      'iconBg': AppColors.blueLight,
      'iconAsset': AppAssets.iconsyrup,
      'medName': "Leukotriene receptor antagonists",
      'medType': "Tablet",
      'medInfo': "+1 | Morning, Afternoon, Evening | After meals",
      'duration': "Duration: 90 days (until Jan 15, 2025)",
      'prescribed': "Prescribed by Dr. Sarah Johnson",
    },
    {
      'iconBg': AppColors.greenLight,
      'iconAsset': AppAssets.iconinhaler,
      'medName': "Inhaled corticosteroids (ICS)",
      'medType': "Inhaler",
      'medInfo': "2 puffs",
      'duration': "Duration: as needed",
      'prescribed': "Prescribed by Dr. Sarah Johnson",
    },
    {
      'iconBg': AppColors.orangeLight,
      'iconAsset': AppAssets.iconinjection,
      'medName': "Insulin",
      'medType': "Injection",
      'medInfo': "10 units | Evening | Before sleep",
      'duration': "Duration: 30 days (until Sep 10, 2024)",
      'prescribed': "Prescribed by Dr. Sarah Johnson",
    },
  ];

  final List<Map<String, dynamic>> _pastMedications = [
    {
      'iconBg': AppColors.greyMedium,
      'iconAsset': AppAssets.icontabletblack,
      'medName': "Antihistamines",
      'medType': "Syrup",
      'medInfo': "5ml | Morning | Empty stomach",
      'duration': "Duration: 90 days (until Jan 15, 2025)",
      'prescribed': "Prescribed by Dr. Sarah Johnson",
    },
    {
      'iconBg': AppColors.greyDark,
      'iconAsset': AppAssets.iconsyrupblack,
      'medName': "Leukotriene receptor antagonists",
      'medType': "Tablet",
      'medInfo': "+1 | Morning, Afternoon, Evening | After meals",
      'duration': "Duration: 90 days (until Jan 15, 2025)",
      'prescribed': "Prescribed by Dr. Sarah Johnson",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTabSelector(),
            14.height,
            if (_selectedTab == 0)
              ..._currentMedications.map((med) => _buildMedicationCard(med))
            else
              ..._pastMedications.map((med) => _buildMedicationCard(med)),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.white,
      title: const CustomText(
        text: "Medication",
        fontWeight: FontWeight.w500,
        fontSize: 18,
      ),
      centerTitle: true,
    );
  }

  Widget _buildTabSelector() {
    return Card(
      elevation: 2,
      child: Container(
        height: 44,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        // decoration: BoxDecoration(
        //     color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            _buildTabItem("Current", 0),
            _buildTabItem("Past", 1),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(String title, int index) {
    bool isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          height: 36,
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primaryLight.withValues(alpha: 0.1)
                : Colors.white,
            borderRadius: BorderRadius.circular(7),
            border: Border.all(
                color: isSelected ? AppColors.primaryLight : Colors.white,
                width: 1.4),
          ),
          alignment: Alignment.center,
          child: CustomText(
            text: title,
            color: isSelected ? AppColors.primaryLight : AppColors.black,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildMedicationCard(Map<String, dynamic> data) {
    return Card(
      elevation: 2,
      child: Container(
        margin: const EdgeInsets.only(bottom: 13),
        padding: const EdgeInsets.all(15),
        // decoration: BoxDecoration(
        //   color: AppColors.white,
        //   borderRadius: BorderRadius.circular(12),
        //   boxShadow: [
        //     BoxShadow(
        //       color: Colors.grey.withValues(alpha: 0.06),
        //       blurRadius: 12,
        //       offset: const Offset(0, 2),
        //     ),
        //   ],
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: data['iconBg'],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(
                    data['iconAsset'],
                    width: 28,
                    height: 28,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.medication, size: 28),
                  ),
                ),
                13.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: data['medName'],
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    CustomText(
                      text: data['medType'],
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: AppColors.greyMedium,
                    ),
                  ],
                ),
              ],
            ),
            8.height,
            CustomText(
              text: data['medInfo'],
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
            CustomText(
              text: data['duration'],
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.greyMedium,
            ),
            CustomText(
              text: data['prescribed'],
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.greyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
