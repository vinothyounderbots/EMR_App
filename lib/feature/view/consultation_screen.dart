import 'package:flutter/material.dart';
import 'package:emr_application/core/extensions/app_extensions.dart';
import 'package:emr_application/config/consultationcard.dart';
import 'package:emr_application/config/app_colors.dart';
import 'package:emr_application/core/custom_widgets/custom_text.dart';
import 'package:emr_application/core/custom_widgets/app_button.dart';
import 'package:emr_application/config/app_assets.dart';
import 'package:emr_application/core/custom_widgets/svg_icon_handler.dart';
import 'package:emr_application/core/custom_widgets/shared_preference.dart';
import 'package:emr_application/feature/view/booking_appointment.dart';
import 'package:emr_application/feature/view/prescription_records.dart';

class ConsultationsScreen extends StatefulWidget {
  const ConsultationsScreen({super.key});

  @override
  State<ConsultationsScreen> createState() => _ConsultationsScreenState();
}

class _ConsultationsScreenState extends State<ConsultationsScreen> {
  int selectedTab = 0;
  List<Map<String, dynamic>> _userAppointments = [];

  final List<Map<String, String>> pastConsultations = [
    {
      "name": "Dr. Michael Chen",
      "specialty": "Cardiologist",
      "date": "Mar 12 2024, 2:30 PM",
      "type": "Online Consultation",
      "image": AppAssets.icondoctor,
    },
    {
      "name": "Dr. Antony Nicholas",
      "specialty": "Dermatologist",
      "date": "Jan 19 2024, 11:15 AM",
      "type": "In-person Visit",
      "image": AppAssets.icondoctor,
    },
    {
      "name": "Dr. Emily Rodriguez",
      "specialty": "Pediatrician",
      "date": "Jan 19 2024, 11:15 AM",
      "type": "In-person Visit",
      "image": AppAssets.icondoctor,
    },
  ];

  @override
  void initState() {
    super.initState();
    SharedPreferencesHelper.appointmentsNotifier
        .addListener(_loadAppointmentsFromNotifier);
    _loadAppointments();
  }

  @override
  void dispose() {
    SharedPreferencesHelper.appointmentsNotifier
        .removeListener(_loadAppointmentsFromNotifier);
    super.dispose();
  }

  void _loadAppointmentsFromNotifier() {
    if (mounted) {
      setState(() {
        _userAppointments = SharedPreferencesHelper.appointmentsNotifier.value;
      });
    }
  }

  Future<void> _loadAppointments() async {
    await SharedPreferencesHelper.getAppointments();
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    text: "Filter Consultations",
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              20.height,
              const CustomText(
                text: "Status",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.greyDark,
              ),
              10.height,
              Wrap(
                spacing: 10,
                children: [
                  _filterChip("All", true),
                  _filterChip("Confirmed", false),
                  _filterChip("Completed", false),
                  _filterChip("Cancelled", false),
                  _filterChip("Pending", false),
                ],
              ),
              20.height,
              const CustomText(
                text: "Type",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.greyDark,
              ),
              10.height,
              Wrap(
                spacing: 10,
                children: [
                  _filterChip("Online", false),
                  _filterChip("In-person", false),
                ],
              ),
              30.height,
              AppButton(
                text: "Apply Filter",
                onPressed: () => Navigator.pop(context),
              ),
              10.height,
            ],
          ),
        );
      },
    );
  }

  Widget _filterChip(String label, bool isSelected) {
    return FilterChip(
      label: CustomText(
        text: label,
        fontSize: 12,
        color: isSelected ? Colors.white : AppColors.black,
      ),
      selected: isSelected,
      onSelected: (val) {},
      selectedColor: AppColors.primaryLight,
      checkmarkColor: Colors.white,
      backgroundColor: Colors.grey.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? AppColors.primaryLight : Colors.grey.shade300,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
            child: GestureDetector(
              onTap: () {
                _showFilterBottomSheet(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgIconHandler.iconFilter(
                  color: AppColors.black,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => selectedTab = 0),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 120),
                        decoration: BoxDecoration(
                          color: selectedTab == 0
                              ? AppColors.primaryLight
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Center(
                          child: CustomText(
                            text: "Upcoming",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: selectedTab == 0
                                ? AppColors.white
                                : AppColors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => selectedTab = 1),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 120),
                        decoration: BoxDecoration(
                          color: selectedTab == 1
                              ? AppColors.primaryLight
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Center(
                          child: CustomText(
                            text: "Past",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: selectedTab == 1
                                ? AppColors.white
                                : AppColors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _loadAppointments,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  if (selectedTab == 0) ...[
                    if (_userAppointments.isEmpty)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: Column(
                            children: [
                              Image.asset(
                                AppAssets.iconcalendartick,
                                width: 60,
                                height: 60,
                                color: AppColors.greyMedium,
                              ),
                              20.height,
                              const CustomText(
                                text: "No upcoming appointments",
                                color: AppColors.greyDark,
                                fontSize: 16,
                              ),
                              10.height,
                              AppButton(
                                text: "Book Now",
                                width: 150,
                                onPressed: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const BookAppointmentScreen(),
                                    ),
                                  );
                                  if (result == true) {
                                    _loadAppointments();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      ...[_userAppointments.last].map((appointment) {
                        return ConsultationCard(
                          doctorImage: AppAssets.icondoctor,
                          name: appointment['doctorName'] ?? "Doctor",
                          specialty: "General Practitioner",
                          statusText: appointment['status'] ?? "Confirmed",
                          statusColor: Colors.green.shade100,
                          statusTextColor: Colors.green.shade800,
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
                                  text:
                                      "${appointment['date']}, ${appointment['time']}",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: AppColors.verydarkgrayishblue,
                                ),
                              ],
                            ),
                            4.height,
                            GestureDetector(
                              onTap: () =>
                                  Navigator.pushNamed(context, '/zoom_meeting'),
                              child: Row(
                                children: [
                                  Image.asset(
                                    AppAssets.iconvideocall,
                                    width: 22,
                                    height: 22,
                                    color: AppColors.greyDark,
                                  ),
                                  8.width,
                                  const CustomText(
                                    text: "Online Consultation",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    color: AppColors.verydarkgrayishblue,
                                  ),
                                ],
                              ),
                            ),
                          ],
                          buttons: [
                            AppButton(
                              text: "Join Call",
                              height: 38,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: AppColors.primaryLight,
                              textColor: Colors.white,
                              onPressed: () =>
                                  Navigator.pushNamed(context, '/zoom_meeting'),
                            ),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                minimumSize: const Size(double.infinity, 38),
                                side: const BorderSide(
                                    color: AppColors.greyMedium),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/consultation_details');
                              },
                              child: const CustomText(
                                text: "View details",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        );
                      }),
                  ] else ...[
                    ...pastConsultations.map((consultation) {
                      return ConsultationCard(
                        doctorImage: consultation["image"]!,
                        name: consultation["name"]!,
                        specialty: consultation["specialty"]!,
                        statusText: "Completed",
                        statusColor:
                            AppColors.greyMedium.withValues(alpha: 0.2),
                        statusTextColor: AppColors.black,
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
                                text: consultation["date"]!,
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                color: AppColors.verydarkgrayishblue,
                              ),
                            ],
                          ),
                          4.height,
                          Row(
                            children: [
                              Image.asset(
                                consultation["type"] == "In-person Visit"
                                    ? AppAssets.iconlocation
                                    : AppAssets.iconvideocall,
                                width: 22,
                                height: 22,
                                color: AppColors.greyDark,
                              ),
                              8.width,
                              CustomText(
                                text: consultation["type"]!,
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                color: AppColors.verydarkgrayishblue,
                              ),
                            ],
                          ),
                        ],
                        buttons: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const PrescriptionRecordsScreen(),
                                ),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: AppColors.greyMedium,
                                  width: 1.2,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              alignment: Alignment.center,
                              child: const CustomText(
                                text: "Prescription & Records",
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                  10.height,
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: selectedTab == 0,
        child: FloatingActionButton(
          backgroundColor: AppColors.primaryLight,
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BookAppointmentScreen(),
              ),
            );
            if (result == true) {
              _loadAppointments();
            }
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
