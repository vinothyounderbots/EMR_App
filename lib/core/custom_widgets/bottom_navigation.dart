import 'package:flutter/material.dart';
import 'package:emr_application/config/app_colors.dart';
import 'package:emr_application/core/custom_widgets/bottom_nav_bar.dart';
import 'package:emr_application/feature/view/dashboard_page.dart';
import 'package:emr_application/feature/view/consultation_screen.dart';
import 'package:emr_application/feature/view/chat.dart';
import 'package:emr_application/feature/report/report.dart';
import 'package:emr_application/feature/view/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bottom_navigation_button',
      theme: ThemeData(
        primaryColor: AppColors.primaryLight,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardPage(),
    const ConsultationsScreen(),
    const ChatPage(),
    const ReportsScreen(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
