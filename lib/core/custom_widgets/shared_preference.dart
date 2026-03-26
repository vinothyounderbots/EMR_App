import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPreferencesHelper {
  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _userIdKey = 'userId';
  static const String _patientDetailsKey = 'patient_details';

  static const String _notificationsEnabledKey = 'notificationsEnabled';
  static const String _darkModeKey = 'darkMode';
  static const String _appointmentsKey = 'appointments';

  static final ValueNotifier<List<Map<String, dynamic>>> appointmentsNotifier =
      ValueNotifier<List<Map<String, dynamic>>>([]);

  static Future<void> saveLoginState(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, true);
    await prefs.setString(_userIdKey, userId);
  }

  static Future<void> savePatientDetails(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_patientDetailsKey, jsonEncode(data));
  }

  static Future<Map<String, dynamic>?> getPatientDetails() async {
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(_patientDetailsKey);

    if (data != null) {
      return jsonDecode(data);
    }
    return null;
  }   

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  static Future<void> clearLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_isLoggedInKey);
    await prefs.remove(_patientDetailsKey);
    await prefs.remove(_userIdKey);
  }

  static Future<void> setNotificationsEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notificationsEnabledKey, enabled);
  }

  static Future<bool> areNotificationsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_notificationsEnabledKey) ?? true;
  }

  static Future<void> setDarkMode(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_darkModeKey, enabled);
  }

  static Future<bool> isDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_darkModeKey) ?? false;
  }

  static Future<void> saveAppointment(Map<String, dynamic> appointment) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> appointments = prefs.getStringList(_appointmentsKey) ?? [];
    appointments.add(jsonEncode(appointment));
    await prefs.setStringList(_appointmentsKey, appointments);

    await getAppointments();
  }

  static Future<List<Map<String, dynamic>>> getAppointments() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> appointmentsJson = prefs.getStringList(_appointmentsKey) ?? [];
    final list = appointmentsJson
        .map((item) => jsonDecode(item) as Map<String, dynamic>)
        .toList();
    appointmentsNotifier.value = list;
    return list;
  }
}
