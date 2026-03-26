import 'package:emr_application/core/custom_widgets/shared_preference.dart';

abstract class AppointmentRepository {
  Future<List<Map<String, dynamic>>> getAppointments();
  Future<void> saveAppointment(Map<String, dynamic> appointment);
  Future<void> deleteAppointment(int index);
}

class SharedPreferencesAppointmentRepository implements AppointmentRepository {
  @override
  Future<List<Map<String, dynamic>>> getAppointments() async {
    return await SharedPreferencesHelper.getAppointments();
  }

  @override
  Future<void> saveAppointment(Map<String, dynamic> appointment) async {
    await SharedPreferencesHelper.saveAppointment(appointment);
  }

  @override
  Future<void> deleteAppointment(int index) async {
    // Note: SharedPreferencesHelper currently doesn't have deleteByIndex,
    // but we can implement it here or in the helper.
    final appointments = await getAppointments();
    if (index >= 0 && index < appointments.length) {
      appointments.removeAt(index);
      // Logic to save the whole list back
    }
  }
}

// Modern Mock Repository for testing and development
class MockAppointmentRepository implements AppointmentRepository {
  @override
  Future<List<Map<String, dynamic>>> getAppointments() async {
    await Future.delayed(const Duration(milliseconds: 800)); // Simulate network
    return [
      {
        'doctorName': 'Dr. Sarah Johnson',
        'specialty': 'Cardiologist',
        'date': '2026-02-15',
        'time': '10:30 AM',
        'type': 'Video Call',
      },
      {
        'doctorName': 'Dr. Michael Chen',
        'specialty': 'Dermatologist',
        'date': '2026-02-20',
        'time': '02:00 PM',
        'type': 'In-Person',
      }
    ];
  }

  @override
  Future<void> saveAppointment(Map<String, dynamic> appointment) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<void> deleteAppointment(int index) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
