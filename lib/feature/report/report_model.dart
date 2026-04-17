// import 'dart:ui';

// enum ReportType { lab, scan }

// class ReportModel {
//   final String iconPath;
//   final Color iconBg;
//   final Color iconColor;
//   final String title;
//   final String date;
//   final String doctor;
//   final ReportType type;

//   ReportModel({
//     required this.iconPath,
//     required this.iconBg,
//     required this.iconColor,
//     required this.title,
//     required this.date,
//     required this.doctor,
//     required this.type,
//   });
// }

import 'dart:ui';

class ReportModel {
  final int id;
  final String test_name;
  final String test_code;
  final String decription;
  final String specimen_type;
  final String container;
  final double volume_ml;
  final String method;
  final double price;
  final String order_of_draw;
  final String instrument;
  final String additive;
  final String instruction;
  final String reference_range;
  final String status;
  final List<SubTestModel> subTests;

  ReportModel({
    required this.id,
    required this.test_name,
    required this.test_code,
    required this.decription,
    required this.specimen_type,
    required this.container,
    required this.volume_ml,
    required this.method,
    required this.price,
    required this.order_of_draw,
    required this.instrument,
    required this.additive,
    required this.instruction,
    required this.reference_range,
    required this.status,
    required this.subTests,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'] ?? 0,
      test_name: json['test_name'] ?? '',
      test_code: json['test_code'] ?? '',
      decription: json['description'] ?? '',
      specimen_type: json['specimen_type']?.toString() ?? '',
      container: json['container']?.toString() ?? '',
      volume_ml: json['volume_ml'] ?? 0,
      method: json['method'] ?? '',
      price: json['price'] ?? 0,
      order_of_draw: json['order_of_draw']?.toString() ?? '',
      instrument: json['instrument'] ?? '',
      additive: json['additive'] ?? '',
      instruction: json['instruction'] ?? '',
      reference_range: json['reference_range'] ?? '',
      status: json['status'] ?? '',
      subTests: (json['sub_tests'] as List<dynamic>?)
              ?.map((e) => SubTestModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class SubTestModel {
  final int id;
  final String subTestName;
  final String? subOptions;
  final String? subChild;

  SubTestModel({
    required this.id,
    required this.subTestName,
    this.subOptions,
    this.subChild,
  });

  factory SubTestModel.fromJson(Map<String, dynamic> json) {
    return SubTestModel(
      id: json['id'] ?? 0,
      subTestName: json['sub_test_name'] ?? '',
      subOptions: json['sub_options'],
      subChild: json['sub_child'],
    );
  }
}