import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:emr_application/config/app_assets.dart';
import 'package:emr_application/config/app_colors.dart';

class SvgIconHandler {
  static Widget _build({
    required String path,
    double? size,
    double? width,
    double? height,
    Color? color,
  }) {
    final double iconWidth = width ?? size ?? 24;
    final double iconHeight = height ?? size ?? 24;

    if (path.endsWith('.svg')) {
      return SvgPicture.asset(
        path,
        width: iconWidth,
        height: iconHeight,
        colorFilter:
            color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      );
    }
    return Image.asset(
      path,
      width: iconWidth,
      height: iconHeight,
      color: color,
    );
  }

  static Widget iconFilter({double size = 18, Color color = AppColors.black}) {
    return _build(path: AppAssets.iconfilter, size: size, color: color);
  }

  static Widget iconNotification({double size = 20, Color? color}) {
    return _build(path: AppAssets.iconnotification, size: size, color: color);
  }

  static Widget iconHome({double size = 24, Color? color}) {
    return _build(path: AppAssets.iconhome, size: size, color: color);
  }

  static Widget iconConsultations({double size = 24, Color? color}) {
    return _build(path: AppAssets.iconconsultations, size: size, color: color);
  }

  static Widget iconChat({double size = 24, Color? color}) {
    return _build(path: AppAssets.iconchat2, size: size, color: color);
  }

  static Widget iconReport({double size = 24, Color? color}) {
    return _build(path: AppAssets.iconreport, size: size, color: color);
  }

  static Widget iconProfile({double size = 24, Color? color}) {
    return _build(path: AppAssets.iconprofile, size: size, color: color);
  }

  static Widget iconSettings({double size = 24, Color? color}) {
    return _build(path: AppAssets.iconsettings, size: size, color: color);
  }

  static Widget iconCalendar({double size = 24, Color? color}) {
    return _build(path: AppAssets.iconcalendar, size: size, color: color);
  }

  static Widget iconArrowBack({double size = 20, Color? color}) {
    return _build(path: AppAssets.iconarrowback, size: size, color: color);
  }

  static Widget iconMedications({double size = 20, Color? color}) {
    return _build(path: AppAssets.iconmedications, size: size, color: color);
  }

  static Widget iconPhone({double size = 20, Color? color}) {
    return _build(path: AppAssets.iconphone, size: size, color: color);
  }

  static Widget iconEmail({double size = 20, Color? color}) {
    return _build(path: AppAssets.iconemail, size: size, color: color);
  }

  static Widget iconAddress({double size = 20, Color? color}) {
    return _build(path: AppAssets.iconaddress, size: size, color: color);
  }

  static Widget iconContact({double size = 20, Color? color}) {
    return _build(path: AppAssets.iconcontact, size: size, color: color);
  }

  static Widget iconHeight({double size = 20, Color? color}) {
    return _build(path: AppAssets.iconheight, size: size, color: color);
  }

  static Widget iconWeight({double size = 20, Color? color}) {
    return _build(path: AppAssets.iconweight, size: size, color: color);
  }

  static Widget iconBP({double size = 20, Color? color}) {
    return _build(path: AppAssets.iconbp, size: size, color: color);
  }

  static Widget iconPulse({double size = 20, Color? color}) {
    return _build(path: AppAssets.iconpulse, size: size, color: color);
  }

  static Widget iconSPO2({double size = 20, Color? color}) {
    return _build(path: AppAssets.iconspo2, size: size, color: color);
  }

  static Widget iconTemperature({double size = 20, Color? color}) {
    return _build(path: AppAssets.icontemperature, size: size, color: color);
  }

  static Widget iconBlood({double size = 20, Color? color}) {
    return _build(path: AppAssets.iconblood, size: size, color: color);
  }

  static Widget iconAllergies({double size = 20, Color? color}) {
    return _build(path: AppAssets.iconallergies, size: size, color: color);
  }

  static Widget iconProblem({double size = 20, Color? color}) {
    return _build(path: AppAssets.iconproblem, size: size, color: color);
  }

  static Widget iconSurgery({double size = 20, Color? color}) {
    return _build(path: AppAssets.iconsurgery, size: size, color: color);
  }

  static Widget iconSearch({double size = 20, Color? color}) {
    return _build(path: AppAssets.iconsearch, size: size, color: color);
  }

  static Widget iconTablet({double size = 28, Color? color}) {
    return _build(path: AppAssets.icontablet, size: size, color: color);
  }

  static Widget iconSyrup({double size = 28, Color? color}) {
    return _build(path: AppAssets.iconsyrup, size: size, color: color);
  }

  static Widget iconInhaler({double size = 28, Color? color}) {
    return _build(path: AppAssets.iconinhaler, size: size, color: color);
  }

  static Widget iconInjection({double size = 28, Color? color}) {
    return _build(path: AppAssets.iconinjection, size: size, color: color);
  }

  static Widget iconTabletBlack({double size = 28, Color? color}) {
    return _build(path: AppAssets.icontabletblack, size: size, color: color);
  }

  static Widget iconSyrupBlack({double size = 28, Color? color}) {
    return _build(path: AppAssets.iconsyrupblack, size: size, color: color);
  }

  static Widget iconToday({double size = 18, Color? color}) {
    return _build(path: AppAssets.icontoday, size: size, color: color);
  }

  static Widget iconVideoCall({double size = 18, Color? color}) {
    return _build(path: AppAssets.iconvideocall, size: size, color: color);
  }

  static Widget iconPdf({double size = 15, Color? color}) {
    return _build(path: AppAssets.iconpdf, size: size, color: color);
  }

  static Widget iconLabResults({double size = 15, Color? color}) {
    return _build(path: AppAssets.iconlabresults, size: size, color: color);
  }

  static Widget iconTime({double size = 20, Color? color}) {
    return _build(path: AppAssets.icontime, size: size, color: color);
  }

  static Widget iconPreviousPage({double size = 20, Color? color}) {
    return _build(path: AppAssets.iconpreviouspage, size: size, color: color);
  }

  static Widget iconPdf2({double size = 36, Color? color}) {
    return _build(path: AppAssets.iconpdf2, size: size, color: color);
  }

  static Widget iconLogin(
      {double width = 348, double height = 48, Color? color}) {
    return _build(
        path: AppAssets.iconlogin, width: width, height: height, color: color);
  }

  static Widget iconCalendar2({double size = 22, Color? color}) {
    return _build(path: AppAssets.iconcalendar2, size: size, color: color);
  }

  static Widget iconLocation({double size = 22, Color? color}) {
    return _build(path: AppAssets.iconlocation, size: size, color: color);
  }

  static Widget iconBookAppointment({double size = 24, Color? color}) {
    return _build(
        path: AppAssets.iconbookappointment, size: size, color: color);
  }

  static Widget iconCarePlan({double size = 24, Color? color}) {
    return _build(path: AppAssets.iconcareplan, size: size, color: color);
  }

  static Widget iconPrescription({double size = 24, Color? color}) {
    return _build(path: AppAssets.iconprescription, size: size, color: color);
  }

  static Widget iconLab({double size = 20, Color? color}) {
    return _build(path: AppAssets.iconlabb, size: size, color: color);
  }

  static Widget iconPrescriptionUpdated({double size = 20, Color? color}) {
    return _build(
        path: AppAssets.iconprescriptionupdated, size: size, color: color);
  }

  static Widget iconCalendarTick({double size = 28, Color? color}) {
    return _build(path: AppAssets.iconcalendartick, size: size, color: color);
  }

  static Widget iconMedical({double size = 24, Color? color}) {
    return _build(path: AppAssets.iconmedical, size: size, color: color);
  }

  static Widget iconChatDoctor({double size = 24, Color? color}) {
    return _build(path: AppAssets.iconchatdoctor, size: size, color: color);
  }

  static Widget fromPath(
      {required String path, double size = 24, Color? color}) {
    return _build(path: path, size: size, color: color);
  }
}
