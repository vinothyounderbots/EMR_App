// import 'dart:convert';
import "dart:convert";

import "package:emr_application/feature/report/report_model.dart";
import "package:http/http.dart" as http;

class ApiServicce {
  static const String baseUrl = "https://cmr247.loca.lt/hms";

  Future<http.Response> login(String userId, String password) async {
    print("Attempting to login with userId: $userId and password: $password");

    final url = Uri.parse("$baseUrl/login/login_patient_post");
    final response = await http.post(url, body: {
      "patient_email": userId,
      "patient_password": password,
    });

    print("Login response status: ${response.statusCode}");
    print("Login response body: ${response.body}");

    return response;
  }

  // Api call for reports

  Future<List<ReportModel>> getLabTest() async{
    final url = Uri.parse("$baseUrl/masterdata/get_lab_tests");
    final response = await http.get(url);

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      final List list = data;      

      print("Lab test response body: ${response.body}");
      return list.map((e) => ReportModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load lab tests");
    }
  }
}
