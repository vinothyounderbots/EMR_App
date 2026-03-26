import 'package:flutter/material.dart';
import 'package:emr_application/config/app_colors.dart';
import 'package:emr_application/config/app_string.dart';
import 'package:emr_application/core/custom_widgets/custom_text.dart';
import 'package:emr_application/core/custom_widgets/bottom_nav_bar.dart';
import 'package:emr_application/core/extensions/app_extensions.dart';

class NoReportScreen extends StatefulWidget {
  const NoReportScreen({super.key});

  @override
  State<NoReportScreen> createState() => _NoReportScreenState();
}

class _NoReportScreenState extends State<NoReportScreen> {
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    setState(() => _selectedIndex = index);

    Future.delayed(const Duration(milliseconds: 100), () {
      if (!mounted) return;
      switch (index) {
        case 0:
          Navigator.pushReplacementNamed(context, '/dashboard');
          break;
        case 1:
          Navigator.pushReplacementNamed(context, '/upcoming-consultation');
          break;
        case 2:
          Navigator.pushReplacementNamed(context, '/chat');
          break;
        case 3:
          Navigator.pushReplacementNamed(context, '/report');
          break;
        case 4:
          Navigator.pushReplacementNamed(context, '/profile');
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: const CustomText(
          text: "Reports",
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomText(
                text: AppStrings.noReportsAvailable,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                textAlign: TextAlign.center,
              ),
              8.height,
              const CustomText(
                text: AppStrings.reportsAppearHere,
                fontSize: 14,
                color: AppColors.greyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
