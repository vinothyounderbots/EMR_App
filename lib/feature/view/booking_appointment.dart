import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:emr_application/config/app_colors.dart';
import 'package:emr_application/core/custom_widgets/custom_text.dart';
import 'package:emr_application/config/app_assets.dart';
import 'package:emr_application/core/custom_widgets/decoration.dart';
import 'package:emr_application/core/extensions/app_extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:emr_application/core/providers/appointment_provider.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({super.key});
  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  String? selectedDoctor;
  String? selectedPriority;
  final List<String> doctors = [
    'Dr. Michael Chen',
    'Dr. Emily Rodriguez',
    'Dr. Antony Nichols',
  ];

  final List<String> priorities = ['Routine', 'Urgent', 'Emergency'];

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   final appointmentProvider = Provider.of<AppointmentProvider>(context, listen: false);
  //   appointmentProvider.fetchAppointments();
  // }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _dateController.text =
            "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
      });
    }
  }

  Future<void> _selectTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _timeController.text = pickedTime.format(context);
      });
    }
  }

  Future<void> _submitAppointment() async {
    if (_dateController.text.isEmpty ||
        _timeController.text.isEmpty ||
        selectedDoctor == null ||
        selectedPriority == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    final appointment = {
      'doctorName': selectedDoctor,
      'date': _dateController.text,
      'time': _timeController.text,
      'priority': selectedPriority,
      'message': _messageController.text,
      'status': 'Confirmed',
    };

    final appointmentProvider =
        Provider.of<AppointmentProvider>(context, listen: false);
    await appointmentProvider.addAppointment(appointment);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Appointment Submitted!')),
      );
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: Image.asset(
            AppAssets.iconpreviouspage,
            width: 20,
            height: 20,
            color: AppColors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const CustomText(
          text: "Book Appointment",
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Select Doctor",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    DropdownButtonFormField<String>(
                      initialValue: selectedDoctor,
                      hint: const Text("Choose Doctor"),
                      decoration: dropdownDecoration(),
                      items: doctors.map((String doctor) {
                        return DropdownMenuItem<String>(
                          value: doctor,
                          child: Text(doctor),
                        );
                      }).toList(),
                      onChanged: (value) =>
                          setState(() => selectedDoctor = value),
                      icon: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: SvgPicture.asset(
                          AppAssets.iconarrowback,
                          width: 7,
                          height: 7,
                          colorFilter: const ColorFilter.mode(
                            AppColors.greyDark,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              16.height,
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Date",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        TextField(
                          controller: _dateController,
                          readOnly: true,
                          onTap: _selectDate,
                          decoration: textFieldDecoration(
                            hintText: "DD/MM/YY",
                            suffixIcon: GestureDetector(
                              onTap: _selectDate,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                  AppAssets.iconcalendar,
                                  width: 22,
                                  height: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Time",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        TextField(
                          controller: _timeController,
                          readOnly: true,
                          onTap: _selectTime,
                          decoration: textFieldDecoration(
                            hintText: "HH:MM",
                            suffixIcon: GestureDetector(
                              onTap: _selectTime,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset(
                                  AppAssets.iconclock,
                                  width: 22,
                                  height: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              16.height,
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Appointment Priority",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    DropdownButtonFormField<String>(
                      initialValue: selectedPriority,
                      hint: const Text("Select Priority"),
                      decoration: dropdownDecoration(),
                      items: priorities.map((String priority) {
                        return DropdownMenuItem<String>(
                          value: priority,
                          child: Text(priority),
                        );
                      }).toList(),
                      onChanged: (value) =>
                          setState(() => selectedPriority = value),
                      icon: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: SvgPicture.asset(
                          AppAssets.iconarrowback,
                          width: 7,
                          height: 7,
                          colorFilter: const ColorFilter.mode(
                            AppColors.greyDark,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              16.height,
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Message",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    TextField(
                      controller: _messageController,
                      maxLines: 4,
                      decoration: textFieldDecoration(hintText: "Your message"),
                    ),
                  ],
                ),
              ),
              30.height,
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: GestureDetector(
                  onTap: _submitAppointment,
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: CustomText(
                        text: "Submit",
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
