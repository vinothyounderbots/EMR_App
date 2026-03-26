import 'package:flutter/material.dart';
import 'package:emr_application/config/app_colors.dart';
import 'package:emr_application/config/app_string.dart';
import 'package:emr_application/core/custom_widgets/custom_text.dart';
import 'package:emr_application/core/extensions/app_extensions.dart';
import 'package:emr_application/core/custom_widgets/bottom_nav_bar.dart';

class NoChatPage extends StatefulWidget {
  const NoChatPage({super.key});

  @override
  State<NoChatPage> createState() => _NoChatPageState();
}

class _NoChatPageState extends State<NoChatPage> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/upcoming-consultation');
        break;
      case 2:
        break;
      case 3:
        Navigator.pushNamed(context, '/prescription');
        break;
      case 4:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: const CustomText(
          text: AppStrings.chatTitle,
          size: 18,
          weight: FontWeight.w400,
          color: AppColors.black,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomText(
              text: AppStrings.noConversations,
              size: 16,
              weight: FontWeight.w500,
              color: AppColors.black,
            ),
            6.height,
            const CustomText(
              text: AppStrings.bookFirstAppointment,
              size: 14,
              color: AppColors.greyDark,
            ),
            20.height,
            Container(
              width: 167.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryLight,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {},
                child: const CustomText(
                  text: AppStrings.bookAppointment,
                  size: 14,
                  weight: FontWeight.w400,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
