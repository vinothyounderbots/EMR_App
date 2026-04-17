import 'package:emr_application/config/patient_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:emr_application/config/app_assets.dart';
import 'package:emr_application/config/app_colors.dart';
import 'package:emr_application/core/custom_widgets/custom_text.dart';
import 'package:emr_application/core/extensions/app_extensions.dart';
import 'package:emr_application/core/custom_widgets/shared_preference.dart';

class ProfilePage extends StatefulWidget {
  // const ProfilePage({super.key});
  const ProfilePage({super.key, this.patient});

  final PatientModel? patient;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool showPersonal = true;
  bool showVitals = false;
  bool showMedical = false;

  bool notificationsEnabled = true;

  // PatientModel? patient;

  @override
  void initState() {
    super.initState();
    // loadProfile();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final notifications =
        await SharedPreferencesHelper.areNotificationsEnabled();
    setState(() {
      notificationsEnabled = notifications;
    });
  }

  // Future<void> loadProfile() async {
  //   final profileData = await SharedPreferencesHelper.getPatientDetails();
  //   if (profileData != null) {
  //     // Use profileData to populate the UI
  //     setState(() {
  //       patient = PatientModel.fromJson(profileData);
  //     });
  //     print("Profile Data: $profileData");
  //   } else {
  //     print("No profile data found.");
  //   }
  // }

  Future<void> _logout() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const CustomText(
            text: 'Logout',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          content: const CustomText(
            text: 'Are you sure you want to logout?',
            fontSize: 16,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const CustomText(
                text: 'Cancel',
                color: AppColors.primary,
              ),
            ),
            TextButton(
              onPressed: () async {
                await SharedPreferencesHelper.clearLoginState();
                if (!context.mounted) return;
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const CustomText(
                text: 'Logout',
                color: AppColors.red,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _sectionHeader(String title, bool isExpanded, VoidCallback onTap) {
    return Card(
      elevation: 2,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          // decoration: BoxDecoration(
          //   color: AppColors.white,
          //   borderRadius: BorderRadius.circular(8),
          //   border: Border.all(color: AppColors.greyBorder),
          // ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: title,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
              SvgPicture.asset(
                AppAssets.iconarrowback,
                width: 7,
                height: 7,
                colorFilter: const ColorFilter.mode(
                  AppColors.greyDark,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: Row(
        children: [
          _buildIcon(icon),
          10.width,
          Expanded(
            child: CustomText(
              text: "$label: $value",
              fontSize: 13,
              color: AppColors.verydarkgrayishblue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(String assetPath) {
    if (assetPath.endsWith('.svg')) {
      return SvgPicture.asset(
        assetPath,
        width: 18,
        height: 18,
      );
    }
    return Image.asset(
      assetPath,
      width: 18,
      height: 18,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
        elevation: 0.5,
        centerTitle: true,
        title: const CustomText(
          text: 'Profile',
          size: 18,
          weight: FontWeight.w500,
          color: AppColors.black,
        ),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout, color: AppColors.primary, size: 22),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
            icon: SvgPicture.asset(
              AppAssets.iconsettings,
              width: 24,
              height: 24,
            ),
            padding: const EdgeInsets.only(right: 15),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset(
                      AppAssets.icondoctor,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(40),
                  //   child: Image.network(
                  //     patient?.image ?? "",
                  //     width: 60,
                  //     height: 60,
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  14.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: (widget.patient?.name.isNotEmpty ?? false)
                            ? widget.patient!.name
                            : "Patient Name",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                      CustomText(
                        text:
                            "${(widget.patient?.age.isNotEmpty ?? false) ? widget.patient!.age : 'Patient Age'} - ${(widget.patient?.gender.isNotEmpty ?? false) ? widget.patient!.gender : 'Patient Gender'}",
                        fontSize: 14,
                        color: AppColors.greyDark,
                      ),
                      CustomText(
                        text: (widget.patient?.patientId.isNotEmpty ?? false)
                            ? "ID: ${widget.patient!.patientId}"
                            : "ID: Patient ID",
                        fontSize: 13,
                        color: AppColors.greyDark,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            14.height,
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/medication_upcoming');
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppAssets.iconmedications,
                        width: 18, height: 18, color: AppColors.white),
                    8.width,
                    const CustomText(
                      text: "Medications",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                    ),
                  ],
                ),
              ),
            ),
            14.height,
            _sectionHeader(
              "Personal Information",
              showPersonal,
              () => setState(() => showPersonal = !showPersonal),
            ),
            if (showPersonal)
              Container(
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    _infoRow(
                        AppAssets.iconphone,
                        "Phone",
                        (widget.patient?.phone.isNotEmpty ?? false)
                            ? widget.patient!.phone
                            : "No phone"),
                    _infoRow(
                        AppAssets.iconemail,
                        "Email",
                        (widget.patient?.email.isNotEmpty ?? false)
                            ? widget.patient!.email
                            : "No email"),
                    _infoRow(
                        AppAssets.iconaddress,
                        "Address",
                        (widget.patient?.address.isNotEmpty ?? false)
                            ? widget.patient!.address
                            : "No address"),
                    _infoRow(
                      AppAssets.iconcontact,
                      "Emergency Contact",
                      (widget.patient?.emergencyContact.isNotEmpty ?? false)
                          ? widget.patient!.emergencyContact
                          : "No emergency contact",
                    ),
                  ],
                ),
              ),
            14.height,
            _sectionHeader(
              "Vitals",
              showVitals,
              () => setState(() => showVitals = !showVitals),
            ),
            if (showVitals)
              Container(
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    _infoRow(
                        AppAssets.iconheight,
                        "Height",
                        (widget.patient?.height.isNotEmpty ?? false)
                            ? widget.patient!.height
                            : "No height"),
                    _infoRow(
                        AppAssets.iconweight,
                        "Weight",
                        (widget.patient?.weight.isNotEmpty ?? false)
                            ? widget.patient!.weight
                            : "No weight"),
                    _infoRow(
                        AppAssets.iconbp,
                        "BP",
                        (widget.patient?.bp.isNotEmpty ?? false)
                            ? widget.patient!.bp
                            : "No BP"),
                    _infoRow(
                        AppAssets.iconpulse,
                        "Pulse",
                        (widget.patient?.pulse.isNotEmpty ?? false)
                            ? widget.patient!.pulse
                            : "No pulse"),
                    _infoRow(
                        AppAssets.iconspo2,
                        "SpO₂",
                        (widget.patient?.spo2.isNotEmpty ?? false)
                            ? widget.patient!.spo2
                            : "No SpO₂"),
                    _infoRow(
                        AppAssets.icontemperature,
                        "Temperature",
                        (widget.patient?.temperature.isNotEmpty ?? false)
                            ? widget.patient!.temperature
                            : "No temperature"),
                  ],
                ),
              ),
            14.height,
            _sectionHeader(
              "Medical Information",
              showMedical,
              () => setState(() => showMedical = !showMedical),
            ),
            if (showMedical)
              Container(
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    _infoRow(
                        AppAssets.iconblood,
                        "Blood Group",
                        (widget.patient?.bloodGroup.isNotEmpty ?? false)
                            ? widget.patient!.bloodGroup
                            : "No blood group"),
                    _infoRow(
                        AppAssets.iconallergies,
                        "Allergies",
                        (widget.patient?.allergies.isNotEmpty ?? false)
                            ? widget.patient!.allergies
                            : "No allergies"),
                    // _infoRow(AppAssets.iconproblem, "Problem",
                    //                   (widget.patient?.problem.isNotEmpty ?? false) ? widget.patient!.problem : "No problem"),
                    // _infoRow(AppAssets.iconsurgery, "Surgery", (widget.patient?.surgery.isNotEmpty ?? false) ? widget.patient!.surgery : "No surgery"),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
