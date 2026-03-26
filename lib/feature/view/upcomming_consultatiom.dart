import 'package:flutter/material.dart';
import 'package:emr_application/core/extensions/app_extensions.dart';
import 'package:emr_application/config/consultationcard.dart';
import 'package:emr_application/config/app_colors.dart';
import 'package:emr_application/core/custom_widgets/custom_text.dart';
import 'package:emr_application/core/custom_widgets/app_button.dart';
import 'package:emr_application/core/custom_widgets/bottom_nav_bar.dart';
import 'package:emr_application/config/app_assets.dart';

class ConsultationsScreen extends StatefulWidget {
  const ConsultationsScreen({super.key});

  @override
  State<ConsultationsScreen> createState() => _ConsultationsScreenState();
}

class _ConsultationsScreenState extends State<ConsultationsScreen> {
  int _selectedTab = 0;
  int _bottomNavIndex = 1;

  final List<Map<String, dynamic>> _consultations = [
    {
      'doctorImage': 'images/michealchen.jpg',
      'name': "Dr. Michael Chen",
      'specialty': "Cardiologist",
      'statusText': "Confirmed",
      'statusColor': Colors.green.shade100,
      'statusTextColor': Colors.green.shade800,
      'time': "Today, 2:30 PM",
      'type': "Online Consultation",
      'isOnline': true,
      'hasJoinButton': true,
    },
    {
      'doctorImage': 'images/emily.png',
      'name': "Dr. Emily Rodriguez",
      'specialty': "Pediatrician",
      'statusText': "Confirmed",
      'statusColor': Colors.green.shade100,
      'statusTextColor': Colors.green.shade800,
      'time': "Dec 15, 3:00 PM",
      'type': "In-person Visit",
      'isOnline': false,
      'hasJoinButton': false,
    },
    {
      'doctorImage': 'images/antony.png',
      'name': "Dr. Antony Nicholas",
      'specialty': "Dermatologist",
      'statusText': "Pending",
      'statusColor': Colors.orange.shade100,
      'statusTextColor': Colors.orange.shade800,
      'time': "Tomorrow, 10:00 AM",
      'type': "In-person Visit",
      'isOnline': false,
      'hasJoinButton': false,
      'isPending': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildTabSelector(),
          if (_selectedTab == 0)
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: _consultations.length,
                separatorBuilder: (context, index) => 10.height,
                itemBuilder: (context, index) {
                  return _buildConsultationCard(_consultations[index]);
                },
              ),
            ),
          if (_selectedTab == 1) const Expanded(child: SizedBox.shrink()),
        ],
      ),
      floatingActionButton: Visibility(
        visible: _selectedTab == 0,
        child: FloatingActionButton(
          backgroundColor: AppColors.primaryLight,
          onPressed: () {},
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _bottomNavIndex,
        onItemTapped: (index) {
          setState(() => _bottomNavIndex = index);
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const CustomText(
        text: "Consultations",
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      ),
      backgroundColor: AppColors.white,
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Image.asset(
            AppAssets.iconfilter,
            width: 16,
            height: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildTabSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(4),
        child: Row(
          children: [
            _buildTabItem("Upcoming", 0),
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
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryLight : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Center(
            child: CustomText(
              text: title,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: isSelected ? AppColors.black : AppColors.background,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConsultationCard(Map<String, dynamic> data) {
    return ConsultationCard(
      doctorImage: data['doctorImage'],
      name: data['name'],
      specialty: data['specialty'],
      statusText: data['statusText'],
      statusColor: data['statusColor'],
      statusTextColor: data['statusTextColor'],
      icons: [
        Row(
          children: [
            Image.asset(
              AppAssets.iconcalendar2,
              width: 22,
              height: 22,
              color: AppColors.greyDark,
            ),
            8.width,
            CustomText(
              text: data['time'],
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.verydarkgrayishblue,
            ),
          ],
        ),
        4.height,
        Row(
          children: [
            Image.asset(
              data['isOnline']
                  ? AppAssets.iconvideocall
                  : AppAssets.iconlocation,
              width: 22,
              height: 22,
              color: AppColors.greyDark,
              errorBuilder: (context, error, stackTrace) => Icon(
                data['isOnline'] ? Icons.videocam : Icons.location_on,
                size: 22,
                color: AppColors.greyDark,
              ),
            ),
            8.width,
            CustomText(
              text: data['type'],
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.verydarkgrayishblue,
            ),
          ],
        ),
      ],
      buttons: [
        if (data['hasJoinButton'] == true)
          AppButton(
            text: "Join Call",
            width: 124,
            height: 38,
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: AppColors.primaryLight,
            textColor: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, '/zoom_meeting');
            },
          ),
        if (data['isPending'] == true) ...[
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 6,
              horizontal: 14,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const CustomText(
              text: "Awaiting Confirmation",
              fontSize: 14,
              color: AppColors.verydarkgrayishblue,
              fontWeight: FontWeight.w400,
            ),
          ),
        ] else ...[
          if (data['hasJoinButton'] == true) ...[
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                side: const BorderSide(color: AppColors.greyMedium),
              ),
              onPressed: () {
                // View details action
              },
              child: const CustomText(
                text: "View details",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
              ),
            ),
          ] else if (data['isPending'] != true) ...[
            AppButton(
              text: "View Details",
              width: 258,
              height: 38,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.primaryLight,
              textColor: Colors.white,
              onPressed: () {},
            ),
          ]
        ],
      ],
    );
  }
}
