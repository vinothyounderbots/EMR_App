import 'dart:math';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ZoomService {
  static const String _accountId = "3PwVyLzCS-mjjLbv3pjGUg";
  static const String _clientId = "gfDkk4QjR1iyNJYhFBekrQ";
  static const String _clientSecret = "P6zGDfJZVcxmi0al0FBb3JijDmROYdc3";

  static String generateMeetingId() {
    final random = Random();
    int first = 300 + random.nextInt(600);
    int second = 1000 + random.nextInt(9000);
    int third = 1000 + random.nextInt(9000);

    return "$first$second$third";
  }

  static Future<Map<String, dynamic>?> createRealZoomMeeting(
      String topic) async {
    try {
      debugPrint("Zoom API: Requesting real meeting for: $topic");

      String? accessToken = await _getAccessToken();

      if (accessToken == null) {
        debugPrint(
            "Zoom API: Falling back to simulated ID (Authentication failed)");
        return {
          "id": generateMeetingId(),
          "join_url": "https://zoom.us/j/${generateMeetingId()}",
          "password": "123",
          "is_simulated": true
        };
      }
      final response = await http.post(
        Uri.parse("https://api.zoom.us/v2/users/me/meetings"),
        headers: {
          "Authorization": "Bearer $accessToken",
          "Content-Type": "application/json"
        },
        body: jsonEncode({
          "topic": topic,
          "type": 2, 
          "settings": {
            "host_video": true,
            "participant_video": true,
            "join_before_host": true,
            "jbh_time": 0, 
            "mute_upon_entry": false,
            "waiting_room": false,
            "meeting_authentication": false
          }
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        debugPrint("Zoom API Success: REAL Meeting Created! ID: ${data['id']}");
        return {
          "id": data['id'].toString(),
          "join_url": data['join_url'],
          "password": data['password'] ?? "",
          "is_simulated": false
        };
      } else {
        debugPrint(
            "Zoom API Create Meeting Error (${response.statusCode}): ${response.body}");
        return null;
      }
    } catch (e) {
      debugPrint("Zoom API Exception: $e");
      return null;
    }
  }

  static Future<String?> _getAccessToken() async {
    if (_accountId == "3PwVyLzCS-mjjLbv3pjGUg" &&
        _clientId == "gfDkk4QjR1iyNJYhFBekrQ") {
    } else if (_accountId == "YOUR_ACCOUNT_ID" ||
        _clientId.isEmpty ||
        _clientSecret.isEmpty) {
      debugPrint(
          "Zoom OAuth: Missing or default credentials in ZoomService.dart");
      return null;
    }

    final String creds = base64Encode(utf8.encode("$_clientId:$_clientSecret"));

    try {
      const String tokenUrl =
          "https://zoom.us/oauth/token?grant_type=account_credentials&account_id=$_accountId";
      debugPrint("Zoom OAuth: Requesting token from $tokenUrl");

      final response = await http.post(
        Uri.parse(tokenUrl),
        headers: {
          "Authorization": "Basic $creds",
          "Content-Type": "application/x-www-form-urlencoded"
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        debugPrint("Zoom OAuth Success: Token obtained");
        return data["access_token"];
      } else {
        debugPrint(
            "Zoom OAuth Error (${response.statusCode}): ${response.body}");
        return null;
      }
    } catch (e) {
      debugPrint("Zoom OAuth Exception: $e");
      return null;
    }
  }

  static String getJoinUrl(String meetingId) {
    String cleanId = meetingId.replaceAll(RegExp(r'[^0-9]'), '');
    return "https://zoom.us/j/$cleanId";
  }
}
