import 'package:emr_application/feature/report/report_model.dart';
import 'package:flutter/material.dart';
import 'package:emr_application/config/app_colors.dart';
import 'package:emr_application/core/custom_widgets/custom_text.dart';

class ReportDetailScreen extends StatelessWidget {
  final ReportModel report;

  const ReportDetailScreen({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Report Details"),
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _item("Test Name", report.test_name),
            _item("Test Code", report.test_code),
            _item("Description", report.decription),
            _item("Method", report.method),
            _item("Price", "₹ ${report.price.toStringAsFixed(2)}"),
            _item("Volume", "${report.volume_ml.toStringAsFixed(2)} ml"),
            _item("Additive", report.additive),
            _item("Instruction", report.instruction),

            if (report.reference_range != null)
              _item("Reference Range", report.reference_range!),

            const SizedBox(height: 20),

            // 🔥 SUB TESTS
            const Text(
              "Sub Tests",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            ...report.subTests.map((sub) {
              return Card(
                child: ListTile(
                  title: Text(sub.subTestName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (sub.subOptions != null)
                        Text("Options: ${sub.subOptions}"),
                      if (sub.subChild != null)
                        Text("Values: ${sub.subChild}"),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _item(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(value),
        ],
      ),
    );
  }
}