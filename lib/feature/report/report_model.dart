import 'dart:ui';

enum ReportType { lab, scan }


class ReportModel {
  final String iconPath;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String date;
  final String doctor;
  final ReportType type;

  ReportModel({
    required this.iconPath,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.date,
    required this.doctor,
    required this.type,
  });
}
