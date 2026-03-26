// import 'dart:convert';
import "package:http/http.dart" as http;

class ApiServicce {
  static const String baseUrl = "http://random24718.loca.lt/hms";

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
}
