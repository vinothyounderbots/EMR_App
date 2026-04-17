// import 'package:emr_application/core/services/api_servicce.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:emr_application/config/app_colors.dart';
// import 'package:emr_application/config/app_assets.dart';
// import 'package:emr_application/config/app_string.dart';
// import 'package:emr_application/core/custom_widgets/custom_text.dart';
// import 'package:emr_application/core/extensions/app_extensions.dart';

// import 'report_model.dart';

// class ReportsScreen extends StatefulWidget {
//   const ReportsScreen({super.key});

//   @override
//   State<ReportsScreen> createState() => _ReportsScreenState();
// }

// class _ReportsScreenState extends State<ReportsScreen> {
//   int _tabIndex = 0;

//   // final List<ReportModel> _reports = [
//   //   ReportModel(
//   //     iconPath: AppAssets.iconthyroid,
//   //     iconBg: AppColors.purpleLight,
//   //     iconColor: AppColors.softblue,
//   //     title: "Thyroid Function Test",
//   //     date: "Dec 5, 2024",
//   //     doctor: "Dr. Emily Davis · Gynecologist",
//   //     type: ReportType.lab,
//   //   ),
//   //   ReportModel(
//   //     iconPath: AppAssets.icondexa,
//   //     iconBg: AppColors.greenLight,
//   //     iconColor: AppColors.green,
//   //     title: "p-DEXA Scan",
//   //     date: "Nov 13, 2024",
//   //     doctor: "Dr. Antony Nicholas · Orthopedist",
//   //     type: ReportType.scan,
//   //   ),
//   // ];

//   final List<ReportModel> _reports = [];
//   bool _isLoading = true;

//   final ApiServicce _apiService = ApiServicce();

//   List<ReportModel> get _filteredReports {
//     if (_tabIndex == 1) {
//       return _reports.where((r) => r.type == ReportType.lab).toList();
//     }
//     if (_tabIndex == 2) {
//       return _reports.where((r) => r.type == ReportType.scan).toList();
//     }
//     return _reports;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: AppColors.white,
//         elevation: 0,
//         centerTitle: true,
//         title: const CustomText(
//           text: "Reports",
//           fontSize: 18,
//           fontWeight: FontWeight.w400,
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 14),
//             child: GestureDetector(
//                 onTap: () {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                         content: Text('This feature is will be soon...')),
//                   );
//                 },
//                 child: AppAssets.iconfilter.endsWith('.svg')
//                     ? SvgPicture.asset(
//                         AppAssets.iconfilter,
//                         width: 18,
//                       )
//                     : Image.asset(AppAssets.iconfilter, width: 18)),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           12.height,
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12),
//             child: Row(
//               children: [
//                 _tabButton("All", 0),
//                 8.width,
//                 _tabButton("Lab Reports", 1),
//                 8.width,
//                 _tabButton("Scan Reports", 2),
//               ],
//             ),
//           ),
//           16.height,
//           Expanded(
//             child: _filteredReports.isEmpty
//                 ? _noReportView()
//                 // : Card(
//                 //   elevation: 2,
//                   // child:
//                   : ListView.builder(
//                       padding: const EdgeInsets.symmetric(horizontal: 10),
//                       itemCount: _filteredReports.length,
//                       itemBuilder: (context, index) {
//                         final report = _filteredReports[index];
//                         return Padding(
//                           padding: const EdgeInsets.only(bottom: 12),
//                           child: Card(
//                             elevation: 2,
//                             child: _reportCard(
//                               iconPath: report.iconPath,
//                               iconBg: report.iconBg,
//                               iconColor: report.iconColor,
//                               title: report.title,
//                               date: report.date,
//                               doctor: report.doctor,
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                 ),
//           // ),
//         ],
//       ),
//     );
//   }

//   Widget _tabButton(String label, int index) {
//     final selected = _tabIndex == index;
//     return Expanded(
//       child: GestureDetector(
//         onTap: () => setState(() => _tabIndex = index),
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 200),
//           padding: const EdgeInsets.symmetric(vertical: 7),
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: selected ? AppColors.primaryLight : AppColors.greyBorder,
//               width: 1.3,
//             ),
//             borderRadius: BorderRadius.circular(7),
//           ),
//           child: Center(
//             child: CustomText(
//               text: label,
//               color: selected ? AppColors.primaryLight : AppColors.black,
//               fontWeight: FontWeight.w500,
//               fontSize: 14,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _noReportView() {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 30),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const CustomText(
//               text: AppStrings.noReportsAvailable,
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//               textAlign: TextAlign.center,
//             ),
//             8.height,
//             const CustomText(
//               text: AppStrings.reportsAppearHere,
//               fontSize: 14,
//               color: AppColors.greyMedium,
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _reportCard({
//     required String iconPath,
//     required Color iconBg,
//     required Color iconColor,
//     required String title,
//     required String date,
//     required String doctor,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(13),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: const [
//           BoxShadow(color: Colors.black12, blurRadius: 6),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 52,
//                 height: 52,
//                 decoration: BoxDecoration(
//                   color: iconBg,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Center(
//                   child: Image.asset(iconPath, width: 30),
//                 ),
//               ),
//               12.width,
//               Expanded(
//                 child: CustomText(
//                   text: title,
//                   fontWeight: FontWeight.w500,
//                   fontSize: 14,
//                 ),
//               ),
//               Image.asset(AppAssets.iconpdf2, width: 36),
//             ],
//           ),
//           10.height,
//           CustomText(
//             text: date,
//             fontSize: 13,
//             color: AppColors.greyMedium,
//           ),
//           CustomText(
//             text: doctor,
//             fontSize: 13,
//             color: AppColors.greyDark,
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:emr_application/core/services/api_servicce.dart';
import 'package:emr_application/feature/view/report_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:emr_application/config/app_colors.dart';
import 'package:emr_application/config/app_assets.dart';
import 'package:emr_application/config/app_string.dart';
import 'package:emr_application/core/custom_widgets/custom_text.dart';
import 'package:emr_application/core/extensions/app_extensions.dart';

import 'report_model.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  int _tabIndex = 0;

  List<ReportModel> _reports = [];
  bool _isLoading = true;

  final ApiServicce _apiService = ApiServicce();

  @override
  void initState() {
    super.initState();

    print("init state called");

    _fetchReports();
  }

  Future<void> _fetchReports() async {
    print("Fetching reports from API...");

    try {
      final data = await _apiService.getLabTest();

      setState(() {
        _reports = data;
        _isLoading = false;
      });
    } catch (e) {
      print("Error: $e");
      setState(() => _isLoading = false);
    }
  }

  List<ReportModel> get _filteredReports {
    return _reports; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: const CustomText(
          text: "Reports",
          fontSize: 18,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: AppAssets.iconfilter.endsWith('.svg')
                ? SvgPicture.asset(AppAssets.iconfilter, width: 18)
                : Image.asset(AppAssets.iconfilter, width: 18),
          ),
        ],
      ),
      body: Column(
        children: [
          12.height,
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredReports.isEmpty
                    ? _noReportView()
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        itemCount: _filteredReports.length,
                        itemBuilder: (context, index) {
                          final report = _filteredReports[index];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReportDetailScreen(report: report),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 2,
                                child: _reportCard(
                                  title: report.test_name,
                                  date: "Code: ${report.test_code}",
                                  doctor: "Method: ${report.method}",
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _noReportView() {
    return const Center(
      child: CustomText(
        text: "No Reports Available",
      ),
    );
  }

  Widget _reportCard({
    required String title,
    required String date,
    required String doctor,
  }) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.science, color: Colors.white),
              ),
              12.width,
              Expanded(
                child: CustomText(
                  text: title,
                  fontWeight: FontWeight.w500,
                ),
              ),
              // Image.asset(AppAssets.iconpdf2, width: 36),
            ],
          ),
          10.height,
          CustomText(text: date),
          CustomText(text: doctor),
        ],
      ),
    );
  }
}
