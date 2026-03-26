import 'package:emr_application/config/patient_model.dart';
import 'package:emr_application/core/custom_widgets/shared_preference.dart';
import 'package:emr_application/feature/view/chat.dart';
import 'package:emr_application/feature/view/consultation_screen.dart';
import 'package:emr_application/feature/view/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:emr_application/config/app_colors.dart';
import 'package:emr_application/core/custom_widgets/custom_text.dart';
import 'package:emr_application/core/custom_widgets/app_button.dart';
import 'package:emr_application/core/custom_widgets/bottom_nav_bar.dart';
import 'package:emr_application/core/extensions/app_extensions.dart';
import 'package:emr_application/config/app_assets.dart';
import 'package:provider/provider.dart';
import 'package:emr_application/core/providers/appointment_provider.dart';

import 'package:emr_application/feature/report/report.dart';
import 'package:emr_application/feature/view/booking_appointment.dart';

import 'package:emr_application/feature/view/prescription_records.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  //Getting patient data from local storage

  @override
  void initState() {
    super.initState();
    loadProfile();
  }


  Future<void> loadProfile() async {
    final profileData = await SharedPreferencesHelper.getPatientDetails();
    if (profileData != null) {
      // Use profileData to populate the UI
      setState(() {
        patient = PatientModel.fromJson(profileData);
      });
      print("Profile Data: $profileData");
    } else {
      print("No profile data found.");
    }
  }
  PatientModel? patient;

  List<Widget> _pages() => [
    HomeScreen(patient : patient),
    const ConsultationsScreen(),
    const ChatPage(),
    const ReportsScreen(),
    ProfilePage(patient : patient),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages(),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final PatientModel? patient;

  // Source - https://stackoverflow.com/a/65185563
// Posted by Josh
// Retrieved 2026-03-14, License - CC BY-SA 4.0


  const HomeScreen({super.key, this.patient});
  // const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String message = DateTime.now().hour < 12 ? "Good morning" : "Good afternoon";
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/images/sarah.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                12.width,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       CustomText(
                        // text: "Good morning,",
                        text:message,
                        color: AppColors.greyDark,
                        fontSize: 16,
                      ),
                      CustomText(
                        text: widget.patient?.name ?? "Patient Name",
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/notifications'),
                  icon: AppAssets.iconnotification.endsWith('.svg')
                      ? SvgPicture.asset(
                          AppAssets.iconnotification,
                          width: 20,
                          height: 20,
                        )
                      : Image.asset(
                          AppAssets.iconnotification,
                          width: 20,
                          height: 20,
                        ),
                ),
              ],
            ),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            10.height,
            Consumer<AppointmentProvider>(
              builder: (context, appointmentProvider, child) {
                final appointments = appointmentProvider.appointments;
                if (appointments.isEmpty) {
                  return const SizedBox.shrink();
                }
                final displayAppointment = appointments.last;
                return Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: AppColors.primaryGradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.only(bottom: 24),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                text: "Next Appointment",
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                              8.height,
                              CustomText(
                                text: displayAppointment['doctorName'] ??
                                    "Doctor",
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.white,
                              ),
                              4.height,
                              const CustomText(
                                text: "Cardiologist",
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.calendar_today_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                      20.height,
                      Row(
                        children: [
                          _appointmentInfoItem(
                            Icons.access_time_rounded,
                            displayAppointment['time'] ?? "--:--",
                          ),
                          24.width,
                          _appointmentInfoItem(
                            Icons.videocam_rounded,
                            "Video Call",
                          ),
                        ],
                      ),
                      20.height,
                      AppButton(
                        text: "Join Call",
                        height: 48,
                        borderRadius: 14,    
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        textColor: AppColors.primary,
                        color: Colors.white,
                        onPressed: () =>
                            Navigator.pushNamed(context, '/zoom_meeting'),
                      ),
                    ],
                  ),
                );
              },
            ),
            const CustomText(
              text: "Quick Actions",
              fontWeight: FontWeight.w400,
              fontSize: 18,
              color: AppColors.black,
            ),
            10.height,
            Row(
              children: [
                _quickAction(
                  "Book Appointment",
                  "Schedule a visit",
                  AppAssets.iconbookappointment,
                  AppColors.blueLight,
                  () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BookAppointmentScreen(),
                      ),
                    );
                    if (result == true) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Appointment booked! View it in Consultations.')),
                      );
                    }
                  },
                ),
                12.width,
                _quickAction(
                  "Care Plan",
                  "View plan",
                  AppAssets.iconcareplan,
                  AppColors.pinkLight,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PrescriptionRecordsScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            12.height,
            Row(
              children: [
                _quickAction(
                  "Prescriptions",
                  "View details",
                  AppAssets.iconprescription,
                  AppColors.greenLight,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PrescriptionRecordsScreen(),
                      ),
                    );
                  },
                ),
                12.width,
                _quickAction(
                  "Medical Records",
                  "View history",
                  AppAssets.iconmedical,
                  AppColors.purpleLight,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ReportsScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            20.height,
            const CustomText(
              text: "Recent Updates",
              fontWeight: FontWeight.w400,
              fontSize: 18,
              color: AppColors.black,
            ),
            8.height,
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/report'),
              child: _updateTile(
                "Lab Results Available",
                "Blood work from Dec 15 - All normal.",
                "2 hours ago",
                AppAssets.iconlabb,
                AppColors.blueLight,
              ),
            ),
            7.height,
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/medication_upcoming'),
              child: _updateTile(
                "Prescription Updated",
                "Metformin dosage adjusted by Dr. Chen",
                "Yesterday",
                AppAssets.iconprescriptionupdated,
                AppColors.greenLight,
              ),
            ),
          ],
        ));
  }

  Widget _appointmentInfoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 18),
        8.width,
        CustomText(
          text: text,
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }

  Widget _quickAction(
    String title,
    String subtitle,
    String iconPath,
    Color bgColor,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 2,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: bgColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.asset(
                    iconPath,
                    width: 24,
                    height: 24,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.category_rounded,
                      color: bgColor,
                    ),
                  ),
                ),
                16.height,
                CustomText(
                  text: title,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: AppColors.black,
                ),
                4.height,
                CustomText(
                  text: subtitle,
                  color: AppColors.greyDark,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _updateTile(
    String title,
    String subtitle,
    String date,
    String iconPath,
    Color bgColor,
  ) {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: Image.asset(iconPath, width: 20, height: 20)),
            ),
            12.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: title,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  4.height,
                  CustomText(
                    text: subtitle,
                    color: AppColors.verydarkgrayishblue,
                    fontSize: 12,
                  ),
                  4.height,
                  CustomText(
                    text: date,
                    color: AppColors.greyMedium,
                    fontSize: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
