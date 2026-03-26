import 'package:flutter/material.dart';
import 'package:emr_application/config/app_colors.dart';
import 'package:emr_application/core/custom_widgets/svg_icon_handler.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  Widget _buildIcon(int index, int selectedIndex, Color unselectedColor) {
    final color =
        index == selectedIndex ? AppColors.primaryLight : unselectedColor;

    switch (index) {
      case 0:
        return SvgIconHandler.iconHome(size: 20, color: color);
      case 1:
        return SvgIconHandler.iconConsultations(size: 20, color: color);
      case 2:
        return SvgIconHandler.iconChat(size: 20, color: color);
      case 3:
        return SvgIconHandler.iconReport(size: 20, color: color);
      case 4:
        return SvgIconHandler.iconProfile(size: 20, color: color);
      default:
        return const Icon(Icons.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const unselectedColor = AppColors.black;

    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
        if (index == selectedIndex) return;

        onItemTapped(index);
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primaryLight,
      unselectedItemColor: unselectedColor,
      elevation: 20,
      backgroundColor: theme.bottomNavigationBarTheme.backgroundColor ??
          theme.colorScheme.surface,
      iconSize: 24,
      selectedFontSize: 12,
      unselectedFontSize: 11,
      items: [
        BottomNavigationBarItem(
          icon: _buildIcon(0, selectedIndex, unselectedColor),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(1, selectedIndex, unselectedColor),
          label: "Consultations",
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(2, selectedIndex, unselectedColor),
          label: "Chat",
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(3, selectedIndex, unselectedColor),
          label: "Report",
        ),
        BottomNavigationBarItem(
          icon: _buildIcon(4, selectedIndex, unselectedColor),
          label: "Profile",
        ),
      ],
    );
  }
}
