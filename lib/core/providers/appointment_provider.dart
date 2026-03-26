import 'package:flutter/material.dart';
import '../custom_widgets/shared_preference.dart';

class AppointmentProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _appointments = [];

  List<Map<String, dynamic>> get appointments => _appointments;

  Future<void> fetchAppointments() async {
    _appointments = await SharedPreferencesHelper.getAppointments();

    print("Fetched Appointments: $_appointments"); // Debug print

    notifyListeners();
  }

  Future<void> addAppointment(Map<String, dynamic> appointment) async {
    await SharedPreferencesHelper.saveAppointment(appointment);
    _appointments.add(appointment);
    notifyListeners();
  }
}
